import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/phonetics.dart';

class DictionaryResponseConveter extends TypeConverter<Dictionary, String> {
  @override
  Dictionary decode(String databaseValue) {
    final decodedDictionary = jsonDecode(databaseValue);
    return decodedDictionary;
  }

  @override
  String encode(Dictionary value) {
    final String dictionaryEncoded = jsonEncode(value);
    return dictionaryEncoded;
  }
}
