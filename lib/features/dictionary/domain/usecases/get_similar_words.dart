import 'package:dartz/dartz.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:riverpod_learn/core/use_case.dart';
import 'package:riverpod_learn/features/dictionary/domain/repositories/dictionary_repository.dart';

class GetSimilarWords
    extends UseCases<GenerateContentResponse, Map<String, dynamic>> {
  final DictionaryRepository repository;

  GetSimilarWords({required this.repository});
  @override
  Future<Either<String, GenerateContentResponse>> call(
      Map<String, dynamic> params) async {
    return await repository.getSimilarWords(params: params);
  }
}
