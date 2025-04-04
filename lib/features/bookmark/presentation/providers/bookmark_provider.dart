import 'package:flutter/material.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';

class BookmarkProvider extends ChangeNotifier {
  List<DictionaryBookmarkResponse> _dictionaryBookmarkData = [];
  String? _time;

  String? get time => _time;
  set time(String? time) {
    _time = time;
    notifyListeners();
  }

  List<DictionaryBookmarkResponse> get dictionaryBookmarkData =>
      _dictionaryBookmarkData;

  set dictionaryBookmarkData(
      List<DictionaryBookmarkResponse> dicitionaryBookmarkData) {
    _dictionaryBookmarkData = dicitionaryBookmarkData;
    notifyListeners();
  }
}
