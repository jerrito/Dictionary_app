
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_learn/core/url.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
part 'provider.g.dart';
// part 'dict.freezed.dart';
@riverpod
Future <List<Dictionary>> dictionary(DictionaryRef ref,{required Map<String,dynamic> params}) async {
  final response = await http.get(
     URL.getUri(
      endpoint:params["text"],
    ),
  );
  final decodedResponse = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return List<DictionaryModel>.from(
        decodedResponse.map((e) => DictionaryModel.fromJson(e)));
  } else {
    throw Exception("Error getting data");
  }
}