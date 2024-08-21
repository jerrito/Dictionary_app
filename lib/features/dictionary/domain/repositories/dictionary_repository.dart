import 'package:dartz/dartz.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';

abstract class DictionaryRepository {
  Future<Either<String, List<Dictionary>>> searchDictionary(
      {required Map<String, dynamic> params});
}
