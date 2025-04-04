part of 'word_bloc.dart';

abstract class WordState extends Equatable {
  const WordState();

  @override
  List<Object> get props => [];
}

class WordInitial extends WordState {}

final class WordSuggestLoaded extends WordState {
  final List<dynamic> words;

  const WordSuggestLoaded({required this.words});
}

final class WordSuggestError extends WordState {
  final String message;

  const WordSuggestError({required this.message});
}

final class WordSuggestLoading extends WordState {}

final class DecodedWordsLoading extends WordState {}

final class DecodedWordsLoaded extends WordState {
  final Map<dynamic, dynamic> data;

  const DecodedWordsLoaded({required this.data});
}

final class InitApppLoaded extends WordState {}

final class RetrieveWordLoaded extends WordState {
  final List<String>? words;

  const RetrieveWordLoaded({required this.words});
}

final class RetrieveWordError extends WordState {
  final String message;

  const RetrieveWordError({required this.message});
}

final class RetrieveWordLoading extends WordState {}

final class SaveWordLoaded extends WordState {
  final bool isSaved;

  const SaveWordLoaded({required this.isSaved});
}

final class SaveWordError extends WordState {
  final String errorMessage;

  const SaveWordError({required this.errorMessage});
}

final class DeleteWordLoaded extends WordState {
  final bool isSaved;

  const DeleteWordLoaded({required this.isSaved});
}

final class DeleteWordError extends WordState {
  final String errorMessage;

  const DeleteWordError({required this.errorMessage});
}

final class DeleteWordsLoaded extends WordState {
  final bool isSaved;

  const DeleteWordsLoaded({required this.isSaved});
}

final class DeleteWordsError extends WordState {
  final String errorMessage;

  const DeleteWordsError({required this.errorMessage});
}

final class TakePictureLoaded extends WordState {
  final File? file;

  const TakePictureLoaded({
    required this.file,
  });
}

final class TakePictureLoading extends WordState {}

final class TakePictureError extends WordState {
  final String errorMessage;

  const TakePictureError({required this.errorMessage});
}
