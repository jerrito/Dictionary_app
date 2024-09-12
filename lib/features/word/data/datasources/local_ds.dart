import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class WordLocalDatasource {
  Stream<List<String>> suggestWord({required Map<String, dynamic> params});
  Future<List<dynamic>> suggestWords({
    required Map<String, dynamic> params,
  });
  Future<bool> saveWord(Map<String, dynamic> params);
  Future<List<String>?> retrieveSavedWords();
}

class WordLocalDatasourceImpl implements WordLocalDatasource {
  final SharedPreferences sharedPreferences;

  WordLocalDatasourceImpl({required this.sharedPreferences});
  final saveWordKey = "saveWordKey";
  StreamController<List<String>> controller = StreamController<List<String>>();
  @override
  Future<List<dynamic>> suggestWords(
      {required Map<String, dynamic> params}) async {
    List<dynamic> myList = [];
    final Map<dynamic, dynamic> decodedWords = params["decodedWords"];
    // myList.addAll(decodedWords.keys.where((e) => e.startsWith(params["text"])));

    final lis = List<String>.from(
        decodedWords.keys.where((e) => e.startsWith(params["text"])));
    print(lis);

    return lis;
  }

  @override
  Future<List<String>?> retrieveSavedWords() async {
    try {
      final words = sharedPreferences.getStringList(saveWordKey);

      return words;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> saveWord(Map<String, dynamic> params) async {
    List<String>? get = await retrieveSavedWords();
    print(get);
    if (get?.contains(params["word"]) ?? false) {
      return false;
    }
    get ??= [];
    get.add(params["word"]);
    sharedPreferences.setStringList(saveWordKey, get);
    return true;
  }

  @override
  Stream<List<String>> suggestWord({required Map<String, dynamic> params}) async* {
    List<dynamic> myList = [];
    final Map<dynamic, dynamic> decodedWords = params["decodedWords"];
    // myList.addAll(decodedWords.keys.where((e) => e.startsWith(params["text"])));

    final lis = List<String>.from(
      decodedWords.keys.where(
        (e) => e.startsWith(
          params["text"],
        ),
      ),
    );
    print(lis);
    // controller.add(event);
    controller.onListen!();
    yield* controller.stream;
  }
}
