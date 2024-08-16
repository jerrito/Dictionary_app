
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_learn/core/url.dart';
import 'package:riverpod_learn/features/movies/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/movies/domain/entities/dictionary.dart';
part 'provider.g.dart';
// part 'dict.freezed.dart';
@riverpod
Future <List<Dictionary>> dictionary(DictionaryRef ref) async {
  final response = await http.get(
    const URL().getUri(
      endpoint: "good",
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