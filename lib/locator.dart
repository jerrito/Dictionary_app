import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_learn/core/network_info.dart';
import 'package:riverpod_learn/features/dictionary/data/datasources/remote_ds.dart';
import 'package:riverpod_learn/features/dictionary/data/repositories/dictionary_repository_impl.dart';
import 'package:riverpod_learn/features/dictionary/domain/repositories/dictionary_repository.dart';
import 'package:riverpod_learn/features/dictionary/domain/usecases/search_dictionary.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/word/data/datasources/local_ds.dart';
import 'package:riverpod_learn/features/word/data/repositories/word_repo_impl.dart';
import 'package:riverpod_learn/features/word/domain/repositories/word_repository.dart';
import 'package:riverpod_learn/features/word/domain/usecases/retrieve_save_words.dart';
import 'package:riverpod_learn/features/word/domain/usecases/save_word.dart';
import 'package:riverpod_learn/features/word/domain/usecases/suggest_word.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
initDependencies() async {
  // data connection
  sl.registerLazySingleton(
    () => DataConnectionChecker(),
  );

  //shared preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

// network
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );
  dictionaryIm();
  word();
}

// word locator
word() {
  //bloc
  sl.registerFactory(
    () => WordBloc(
      suggestWord: sl(),
      retrieveSaveWords: sl(),
      saveWord: sl(),
    ),
  );

  // usecases

  sl.registerLazySingleton(
    () => SaveWord(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => RetrieveSaveWords(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => SuggestWord(
      repository: sl(),
    ),
  );
// repository
  sl.registerLazySingleton<WordSuggestionRepository>(
    () => WordSuggestionRepositoryImpl(
      wordLocalDatasource: sl(),
    ),
  );

// data source
  sl.registerLazySingleton<WordLocalDatasource>(
    () => WordLocalDatasourceImpl(
      sharedPreferences: sl(),
    ),
  );
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
