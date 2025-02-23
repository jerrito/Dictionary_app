import 'dart:convert';

import 'package:floor/floor.dart';

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
