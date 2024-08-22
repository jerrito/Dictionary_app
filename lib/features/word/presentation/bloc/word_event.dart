part of 'word_bloc.dart';

abstract class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object> get props => [];
}

class SearchWordEvent extends WordEvent {
  final Map<String, dynamic> params;
  const SearchWordEvent({required this.params});
}
