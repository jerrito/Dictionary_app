part of 'word_bloc.dart';

abstract class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object> get props => [];
}

class WordSuggestEvent extends WordEvent {
  final Map<String, dynamic> params;
  const WordSuggestEvent({required this.params});
}

class DecodeWordsEvent extends WordEvent {
  final Map<String, dynamic> params;

  const DecodeWordsEvent({required this.params});
}

class RetrieveWordEvent extends WordEvent{
  final Map<String, dynamic> params;

  const RetrieveWordEvent({required this.params});

}
class SaveWordEvent extends WordEvent{
  final Map<String, dynamic> params;

  const SaveWordEvent({required this.params});

}
class InitAppEvent extends WordEvent {}
