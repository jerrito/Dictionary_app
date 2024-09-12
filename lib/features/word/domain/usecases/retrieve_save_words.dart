import 'package:dartz/dartz.dart';
import 'package:riverpod_learn/core/use_case.dart';
import 'package:riverpod_learn/features/word/domain/repositories/word_repository.dart';

class RetrieveSaveWords extends UseCases<List<String>?,Map<String,dynamic>> {
  final WordSuggestionRepository repository;

  RetrieveSaveWords({required this.repository});
  @override
  Future<Either<String, List<String>?>> call(params) async {
    return await repository.retrieveSavedWords(params);
  }
}
