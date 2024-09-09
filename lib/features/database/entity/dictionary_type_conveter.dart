import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';

class DictionaryResponseConveter extends TypeConverter<DictionaryModel, String> {
  @override
  DictionaryModel decode(String databaseValue) {
    final decodedDictionary = jsonDecode(databaseValue);
    return decodedDictionary;
  }

  @override
  String encode(DictionaryModel? value) {
    final String dictionaryEncoded = jsonEncode(value);
    return dictionaryEncoded;
  }
}
