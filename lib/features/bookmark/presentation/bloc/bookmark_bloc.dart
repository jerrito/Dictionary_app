import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_learn/features/bookmark/presentation/providers/bookmark_provider.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/main.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  final BookmarkProvider provider;
  BookmarkBloc({
    required this.provider,
  }) : super(BookmarkInitial()) {
    on<BookmarkEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future<List<DictionaryBookmarkResponse>> readAllDictionary() async {
    return database!.wordDao.getAllBookmark();
  }

  Future<bool> deleteDictionaryData(DictionaryBookmarkResponse response) async {
    final data =
        await database?.wordDao.deleteBookmarkDictionaryResponse(response);
    return true;
  }

  Future<bool> deleteDictionaryList(
      List<DictionaryBookmarkResponse> list) async {
    try {
      final data =
          await database?.wordDao.deleteListDictionaryBookmarkResponse(list);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> insertData(
      Map<dynamic, dynamic>? json, String word, BuildContext context) async {
    try {
      final readDict = await readAllDictionary();
      final isWordStored = readDict.any((e) => e.word == word);

      if (!isWordStored) {
        await database?.wordDao.insertBookmarkData(
          DictionaryBookmarkResponse(
            word: word,
            dictionary: json,
          ),
        );
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Bookmarked successfully",
            ),
          ),
        );
        final allBookmark = await readAllDictionary();
        provider.dictionaryBookmarkData = allBookmark;
      }
    } catch (e) {
      // print(e.toString());
      // emit(state)
    }
  }

  Future<DictionaryBookmarkResponse?> getResponse(String word) async {
    try {
      final response =
          await database?.wordDao.getDictionaryBookmarkResponse(word);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
