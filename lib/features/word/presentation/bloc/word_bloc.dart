import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/json.dart';
import 'package:riverpod_learn/core/use_case.dart';
import 'package:riverpod_learn/features/word/domain/usecases/delete_word.dart';
import 'package:riverpod_learn/features/word/domain/usecases/delete_words.dart';
import 'package:riverpod_learn/features/word/domain/usecases/retrieve_save_words.dart';
import 'package:riverpod_learn/features/word/domain/usecases/save_word.dart';
import 'package:riverpod_learn/features/word/domain/usecases/suggest_word.dart';
import 'package:image_picker/image_picker.dart';
part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final SuggestWord suggestWord;
  final RetrieveSaveWords retrieveSaveWords;
  final SaveWord saveWord;
  final DeleteWords deleteWords;
  final DeleteWord deleteWord;
  final ImagePicker imagePicker;
  StreamController<List<String>> streamController =
      StreamController<List<String>>();
  WordBloc({
    required this.retrieveSaveWords,
    required this.suggestWord,
    required this.saveWord,
    required this.deleteWords,
    required this.deleteWord,
    required this.imagePicker,
  }) : super(WordInitial()) {
    on<WordEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<WordSuggestEvent>(
      (event, emit) async {
        emit(WordSuggestLoading());
        final response = await suggestWord.call(event.params);
        emit(
          response.fold(
            (error) => WordSuggestError(
              message: error,
            ),
            (response) => WordSuggestLoaded(words: response),
          ),
        );
      },
      // transformer: restartable(),
    );

    on<WordSuggestEndEvent>(
      (event, emit) => emit(WordInitial()),
    );

    //! RETRIEVE WORDS
    on<RetrieveWordEvent>((event, emit) async {
      emit(RetrieveWordLoading());
      final words = await retrieveSaveWords.call(NoParams());
      emit(
        words.fold(
          (error) => RetrieveWordError(
            message: error,
          ),
          (words) => RetrieveWordLoaded(
            words: words,
          ),
        ),
      );
    });

    //! SAVE WORDS
    on<SaveWordEvent>((event, emit) async {
      final words = await saveWord.call(event.params);
      emit(
        words.fold(
          (error) => DeleteWordError(
            errorMessage: error,
          ),
          (isWordSaved) => SaveWordLoaded(
            isSaved: isWordSaved,
          ),
        ),
      );
    });

    on<DecodeWordsEvent>((event, emit) async {
      emit(DecodedWordsLoading());
      final response = await decodeWords(event.params);
      emit(DecodedWordsLoaded(data: response));
    });

    on<DeleteWordsEvent>((event, emit) async {
      final response = await deleteWords(event.words);
      print(response);
      emit(response.fold((error) => (DeleteWordsError(errorMessage: error)),
          (response) {
        return DeleteWordsLoaded(isSaved: response);
      }));
    });
    on<DeleteWordEvent>((event, emit) async {
      final response = await deleteWord(event.params);
      print(response);
      emit(response.fold((error) => (DeleteWordError(errorMessage: error)),
          (response) {
        return DeleteWordLoaded(isSaved: response);
      }));
    });

    on<InitAppEvent>((event, emit) {
      emit(InitApppLoaded());
    });

    on<TakePictureEvent>((event, emit) async {
      File? file;
      emit(TakePictureLoading());
      try {
        final XFile? photo =
            await imagePicker.pickImage(source: ImageSource.camera);
        if (photo != null) {
          file = File(photo.path);
          emit(TakePictureLoaded(
            file: file,
          ));
        } else {
          emit(const TakePictureError(errorMessage: "File is null"));
        }
      } catch (e) {
        emit(const TakePictureError(errorMessage: "File is null"));
      }
    });
  }

  Future<Map<dynamic, dynamic>> decodeWords(Map<String, dynamic> params) async {
    final words = await DefaultAssetBundle.of(params["context"])
        .loadString("assets/json/words_dictionary.json");
    final Map<dynamic, dynamic> decodedWords = jsonDecode(words);

    return decodedWords;
  }

  Stream<List<dynamic>> suggestWords(
      {required Map<String, dynamic> params}) async* {
    List<dynamic> myList = [];
    final words = await DefaultAssetBundle.of(params["context"])
        .loadString(DictionaryJson.json);
    final Map<dynamic, dynamic> decodedWords = jsonDecode(words);
    myList.addAll(decodedWords.keys.where((e) => e.startsWith(params["text"])));

    // final lis=List<String>.from(decodedWords.keys.where((e)=>e.contains(params["texts"])));

    yield myList;
  }
}
