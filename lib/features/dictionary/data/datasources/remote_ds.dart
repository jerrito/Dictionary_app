import 'dart:convert';

import 'package:riverpod_learn/core/url.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:http/http.dart' as http;
import 'package:google_generative_ai/google_generative_ai.dart';

abstract class DictionaryRemoteDatasource {
  Future<List<Dictionary>> searchDictionary(
      {required Map<String, dynamic> params});

  Future<GenerateContentResponse> getSimilarWords(Map<String, dynamic> params);
}

class DictionaryRemoteDatasourceImpl implements DictionaryRemoteDatasource {
  final model = GenerativeModel(
      model: "gemini-1.5-flash-latest",
      apiKey: "AIzaSyDW10Q0r1_seHA_vr-F3MjihEfKT4qPjsA");
  @override
  Future<List<Dictionary>> searchDictionary(
      {required Map<String, dynamic> params}) async {
    final response = await http.get(
      URL.getUri(
        endpoint: params["text"],
      ),
    );
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return List<DictionaryModel>.from(
        decodedResponse.map(
          (e) => DictionaryModel.fromJson(e),
        ),
      );
    } else {
      throw (decodedResponse["message"]);
    }
  }

  @override
  Future<GenerateContentResponse> getSimilarWords(
      Map<String, dynamic> params) async {
    final content = [
      Content.text(
        "Provide similar words and the etymology (origin) of the word  ${params["word"]}. Include synonyms and the origin of the word in json format. The json format should like this {'word': 'fight','origin': 'The word 'fight' comes from the Old English word 'feohtan', which meant 'to contend, struggle, battle'.','synonyms': ['battle','combat',]",
      )
    ];

    final response = await model.generateContent(content);
    return response;
  }
}
