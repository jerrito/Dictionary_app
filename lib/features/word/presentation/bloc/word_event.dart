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

class WordSuggestEndEvent extends WordEvent {}

class DecodeWordsEvent extends WordEvent {
  final Map<String, dynamic> params;

  const DecodeWordsEvent({required this.params});
}

class RetrieveWordEvent extends WordEvent {
  const RetrieveWordEvent();
}

class SaveWordEvent extends WordEvent {
  final Map<String, dynamic> params;

  const SaveWordEvent({required this.params});
}

class DeleteWordEvent extends WordEvent {
  final Map<String, dynamic> params;

  const DeleteWordEvent({required this.params});
}

class DeleteWordsEvent extends WordEvent {
  final List<String> words;

  const DeleteWordsEvent({required this.words});
}

class TakePictureEvent extends WordEvent {
  const TakePictureEvent();
}

class InitAppEvent extends WordEvent {}
