import 'package:dartz/dartz.dart';

abstract class WordSuggestionRepository {
  // suggest words
  Future<Either<String, List<dynamic>>> suggestWords(
      {required Map<String, dynamic> params});

  // retrieve saved words
  Future<Either<String, List<String>?>> retrieveSavedWords();

//save word
  Future<Either<String, bool>> saveWord(Map<String, dynamic> params);

// delete words
  Future<Either<String, bool>> deleteWords(List<String> words);
// delete word
  Future<Either<String, bool>> deleteWord(Map<String, dynamic> params);
}
