import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/json.dart';
import 'package:riverpod_learn/features/word/domain/usecases/retrieve_save_words.dart';
import 'package:riverpod_learn/features/word/domain/usecases/save_word.dart';
import 'package:riverpod_learn/features/word/domain/usecases/suggest_word.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final SuggestWord suggestWord;
  final RetrieveSaveWords retrieveSaveWords;
  final SaveWord saveWord;
  StreamController<List<String>> streamController =
      StreamController<List<String>>();
  WordBloc({
    required this.retrieveSaveWords,
    required this.suggestWord,
    required this.saveWord,
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

    //! RETRIEVE WORDS
    on<RetrieveWordEvent>((event, emit) async {
      emit(RetrieveWordLoading());
      final words = await retrieveSaveWords.call(event.params);
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
          (error) => SaveWordError(
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

    on<InitAppEvent>((event, emit) {
      emit(InitApppLoaded());
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
    print(decodedWords);
    myList.addAll(decodedWords.keys.where((e) => e.startsWith(params["text"])));

    // final lis=List<String>.from(decodedWords.keys.where((e)=>e.contains(params["texts"])));

    yield myList;
  }
}
