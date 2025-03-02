import 'package:dartz/dartz.dart';
import 'package:riverpod_learn/core/use_case.dart';
import 'package:riverpod_learn/features/word/domain/repositories/word_repository.dart';

class DeleteWords extends UseCases<bool, List<String>> {
  final WordSuggestionRepository repository;

  DeleteWords({required this.repository});
  @override
  Future<Either<String, bool>> call(params) async {
    return await repository.deleteWords(params);
  }
}
