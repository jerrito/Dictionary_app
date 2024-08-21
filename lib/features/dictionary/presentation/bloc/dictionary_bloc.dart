import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:riverpod_learn/features/dictionary/domain/usecases/search_dictionary.dart';

part 'dictionary_event.dart';
part 'dictionary_state.dart';

class DictionaryBloc extends Bloc<DictionaryEvent, DictionaryState> {
  final SearchDictionary searchDictionary;
  DictionaryBloc({required this.searchDictionary})
      : super(DictionartInitState()) {
    on<SearchDictionaryEvent>(
      (event, emit) async {
        emit(SearchDictionaryLoading());
        final response = await searchDictionary.call(event.params);
        emit(
          response.fold(
            (e) => SearchDictionaryError(
              errorMessage: e,
            ),
            (response) => SearchDictionaryLoaded(
              dictionaryInfo: response,
            ),
          ),
        );
      },
      transformer: restartable(),
    );
  }
}
