import 'dart:convert';

import 'package:riverpod_learn/core/url.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:http/http.dart' as http;

abstract class DictionaryRemoteDatasource {
  Future<List<Dictionary>> searchDictionary(
      {required Map<String, dynamic> params});
}

class DictionaryRemoteDatasourceImpl implements DictionaryRemoteDatasource {
  @override
  Future<List<Dictionary>> searchDictionary(
      {required Map<String, dynamic> params}) async {
    final response = await http.get(
      URL.getUri(
        endpoint: params["text"],
      ),
    );
    final decodedResponse = jsonDecode(response.body);
    print(decodedResponse);
    if (response.statusCode == 200) {
      return List<DictionaryModel>.from(
          decodedResponse.map((e) => DictionaryModel.fromJson(e)));
    } else {
      throw Exception("Error getting data");
    }
  }
}
