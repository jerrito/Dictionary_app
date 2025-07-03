import 'package:dartz/dartz.dart';
import 'package:google_generative_ai/src/api.dart';
import 'package:riverpod_learn/core/network_info.dart';
import 'package:riverpod_learn/features/dictionary/data/datasources/remote_ds.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:riverpod_learn/features/dictionary/domain/repositories/dictionary_repository.dart';

class DictionaryRepositoryImpl implements DictionaryRepository {
  final NetworkInfo networkInfo;
  final DictionaryRemoteDatasource remoteDatasource;

  DictionaryRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });
  @override
  Future<Either<String, List<Dictionary>>> searchDictionary(
      {required Map<String, dynamic> params}) async {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await remoteDatasource.searchDictionary(params: params);
        return Right(response);
      } catch (e) {
        return Left(
          e.toString(),
        );
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }

  @override
  Future<Either<String, GenerateContentResponse>> getSimilarWords(
      {required Map<String, dynamic> params}) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getSimilarWords(params);
        return Right(response);
      } catch (e) {
        return Left(
          e.toString(),
        );
      }
    } else {
      return Left(networkInfo.noNetowrkMessage);
    }
  }
}
