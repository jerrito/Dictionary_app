part of 'word_bloc.dart';

abstract class WordState extends Equatable {
  const WordState();  

  @override
  List<Object> get props => [];
}
class WordInitial extends WordState {}


final class SearchWordLoaded extends WordState{
final   List<dynamic> words;

  const SearchWordLoaded({required this.words});
}

final class SearchWordError extends WordState{
final   String message;

  const SearchWordError({required this.message});
}

final class SearchWordLoading extends WordState{}