import 'package:dartz/dartz.dart';
import 'package:riverpod_learn/core/use_case.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:riverpod_learn/features/dictionary/domain/repositories/dictionary_repository.dart';

class SearchDictionary
    extends UseCases<List<Dictionary>, Map<String, dynamic>> {
  final DictionaryRepository repository;

  SearchDictionary({required this.repository});
  @override
  Future<Either<String, List<Dictionary>>> call(
      Map<String, dynamic> params) async {
    return await repository.searchDictionary(params: params);
  }
}
