import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_learn/core/network_info.dart';
import 'package:riverpod_learn/features/dictionary/data/datasources/remote_ds.dart';
import 'package:riverpod_learn/features/dictionary/data/repositories/dictionary_repository_impl.dart';
import 'package:riverpod_learn/features/dictionary/domain/repositories/dictionary_repository.dart';
import 'package:riverpod_learn/features/dictionary/domain/usecases/search_dictionary.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';

final sl = GetIt.instance;
initDependencies() {
  // data connection
  sl.registerLazySingleton(
    () => DataConnectionChecker(),
  );

// network
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );
  dictionaryIm();
}

//dictionary location
void dictionaryIm() {
  //bloc
  sl.registerFactory(
    () => DictionaryBloc(
      searchDictionary: sl(),
    ),
  );

  //usecase
  sl.registerLazySingleton(
    () => SearchDictionary(
      repository: sl(),
    ),
  );

  //repository

  sl.registerLazySingleton<DictionaryRepository>(
    () => DictionaryRepositoryImpl(
      remoteDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  //remote data source
  sl.registerLazySingleton<DictionaryRemoteDatasource>(
    () => DictionaryRemoteDatasourceImpl(),
  );
}
