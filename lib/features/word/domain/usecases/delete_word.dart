import 'package:dartz/dartz.dart';
import 'package:riverpod_learn/core/use_case.dart';
import 'package:riverpod_learn/features/word/domain/repositories/word_repository.dart';

class DeleteWord extends UseCases<bool, Map<String, dynamic>> {
  final WordSuggestionRepository repository;

  DeleteWord({required this.repository});
  @override
  Future<Either<String, bool>> call(params) async {
    return await repository.deleteWord(params);
  }
}
