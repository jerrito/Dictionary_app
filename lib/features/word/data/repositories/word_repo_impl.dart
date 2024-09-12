import 'package:dartz/dartz.dart';
import 'package:riverpod_learn/features/word/data/datasources/local_ds.dart';
import 'package:riverpod_learn/features/word/domain/repositories/word_repository.dart';

class WordSuggestionRepositoryImpl implements WordSuggestionRepository {
  final WordLocalDatasource wordLocalDatasource;

  WordSuggestionRepositoryImpl({required this.wordLocalDatasource});
  @override
  Future<Either<String, List<dynamic>>> suggestWords(
      {required Map<String, dynamic> params}) async {
    try {
      final response = await wordLocalDatasource.suggestWords(
        params: params,
      );
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<String>?>> retrieveSavedWords(
      Map<String, dynamic> params) async {
    final words = await wordLocalDatasource.retrieveSavedWords(params);
    return Right(words);
  }

  @override
  Future<Either<String, bool>> saveWord(Map<String, dynamic> params) async {
    final word = await wordLocalDatasource.saveWord(params);
    if (word == true) {
      return Right(word);
    } else {
      return const Left("");
    }
  }
}
