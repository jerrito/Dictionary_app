import 'package:dartz/dartz.dart';

abstract class WordSuggestionRepository {
  // suggest words
  Future<Either<String, List<dynamic>>> suggestWords(
      {required Map<String, dynamic> params});

  // retrieve saved words
  Future<Either<String, List<String>?>> retrieveSavedWords(
      Map<String, dynamic> params);

//save word
  Future<Either<String,bool>> saveWord(Map<String, dynamic> params);
}
