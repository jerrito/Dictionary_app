import 'package:flutter/material.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';

class BookmarkProvider extends ChangeNotifier {
  List<DictionaryBookmarkResponse> _dictionaryBookmarkData = [];

  List<DictionaryBookmarkResponse> get dictionaryBookmarkData =>
      _dictionaryBookmarkData;

  set dictionaryBookmarkData(
      List<DictionaryBookmarkResponse> dicitionaryBookmarkData) {
    _dictionaryBookmarkData = dicitionaryBookmarkData;
    notifyListeners();
  }
}
