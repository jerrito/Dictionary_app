import 'dart:convert';

import 'package:flutter/material.dart';

abstract class WordLocalDatasource {
  Future<List<dynamic>> suggestWords(
      {required Map<String, dynamic> params,});
}

class WordLocalDatasourceImpl implements WordLocalDatasource {
  @override
  Future<List<dynamic>> suggestWords(
      {required Map<String, dynamic> params}) async {
    List<dynamic> myList = [];
    final words = await DefaultAssetBundle.of(params["context"])
        .loadString("assets/json/words_dictionary.json");
    final Map<dynamic, dynamic> decodedWords = jsonDecode(words);
    // print(decodedWords);
    myList.addAll(decodedWords.keys.where((e) => e.startsWith(params["text"])));

    // final lis=List<String>.from(decodedWords.keys.where((e)=>e.contains(params["texts"])));

    return myList;
  }
}
