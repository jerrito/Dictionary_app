import 'dart:convert';

import 'package:floor/floor.dart';

class DictionaryResponseConveter
    extends TypeConverter<Map<String, dynamic>?, String> {
  @override
  Map<String, dynamic> decode(String databaseValue) {
    final decodedDictionary = jsonDecode(databaseValue);
    return decodedDictionary;
  }

  @override
  String encode(Map<String, dynamic>? value) {
    final String dictionaryEncoded = jsonEncode(value);
    return dictionaryEncoded;
  }
}
