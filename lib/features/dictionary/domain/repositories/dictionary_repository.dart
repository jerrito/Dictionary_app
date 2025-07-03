import 'package:dartz/dartz.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

abstract class DictionaryRepository {
  Future<Either<String, List<Dictionary>>> searchDictionary(
      {required Map<String, dynamic> params});

  Future<Either<String, GenerateContentResponse>> getSimilarWords(
      {required Map<String, dynamic> params});
}
