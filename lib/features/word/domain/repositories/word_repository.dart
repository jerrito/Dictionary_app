import 'package:dartz/dartz.dart';

abstract class WordSuggestionRepository{
  Future<Either<String,List<dynamic>>> suggestWords({required Map<String,dynamic> params});
}
