import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';

class DictionaryResponseConveter
    extends TypeConverter<Map<dynamic, dynamic>?, String> {
  @override
  Map<dynamic, dynamic>? decode(String databaseValue) {
    final decodedDictionary = jsonDecode(databaseValue);
    return decodedDictionary;
  }

  @override
  String encode(Map<dynamic, dynamic>? value) {
    final String dictionaryEncoded = jsonEncode(value);
    return dictionaryEncoded;
  }
}
