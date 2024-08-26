import 'package:dartz/dartz.dart';
import 'package:riverpod_learn/core/use_case.dart';
import 'package:riverpod_learn/features/word/domain/repositories/word_repository.dart';

class SuggestWord extends UseCases<List<dynamic>,Map<String,dynamic>>{
  final WordSuggestionRepository repository;

  SuggestWord({required this.repository});
  
  @override
  Future<Either<String, List>> call(Map<String, dynamic> params) async {
     return await repository.suggestWords(params: params);

  }
 

 }