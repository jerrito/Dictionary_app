import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  WordBloc() : super(WordInitial()) {
    on<WordEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
