import 'package:flutter/material.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';

class DictionaryProvider extends ChangeNotifier {
  List<DictionaryResponse>? _getAllData;

  List<DictionaryResponse>? get getAllData => _getAllData;

  set getAllData(List<DictionaryResponse>? all) {
    _getAllData = all;
    notifyListeners();
  }
}
