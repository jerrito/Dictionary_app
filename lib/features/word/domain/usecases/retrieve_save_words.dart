import 'package:dartz/dartz.dart';
import 'package:riverpod_learn/core/use_case.dart';
import 'package:riverpod_learn/features/word/domain/repositories/word_repository.dart';

class RetrieveSaveWords extends UseCases {
  final WordSuggestionRepository repository;

  RetrieveSaveWords({required this.repository});
  @override
  Future<Either<String, dynamic>> call(params) async {
    return await repository.retrieveSavedWords(params);
  }
}
