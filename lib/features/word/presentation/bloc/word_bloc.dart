import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_learn/features/word/domain/usecases/suggest_word.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  final SuggestWord suggestWord;
  WordBloc({required this.suggestWord}) : super(WordInitial()) {
    on<WordEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SearchWordEvent>(
      (event, emit) async {
        emit(SearchWordLoading());
        final response = await suggestWord.call(event.params);
        emit(
          response.fold(
            (error) => SearchWordError(
              message: error,
            ),
            (response) => SearchWordLoaded(words: response),
          ),
        );
      },
      transformer: restartable(),
    );
  }
}
