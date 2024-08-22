import 'dart:convert';

import 'package:flutter/material.dart';

abstract class WordLocalDatasource {
  Future<List<dynamic>> suggestWords(
      {required Map<String, dynamic> params, required BuildContext context});
}

class WordLocalDatasourceImpl implements WordLocalDatasource {
  @override
  Future<List<dynamic>> suggestWords(
      {required Map<String, dynamic> params,
      required BuildContext context}) async {
    List<dynamic> myList = [];
    final words = await DefaultAssetBundle.of(context)
        .loadString("assets/json/words_dictionary.json");
    final Map<dynamic, dynamic> decodedWords = jsonDecode(words);
    // print(decodedWords);
    myList.addAll(decodedWords.keys.where((e) => e.startsWith(params["text"])));

    // final lis=List<String>.from(decodedWords.keys.where((e)=>e.contains(params["texts"])));

    return myList;
  }
}
