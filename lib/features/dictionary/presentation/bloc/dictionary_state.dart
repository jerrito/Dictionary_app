part of 'dictionary_bloc.dart';

sealed class DictionaryState {}

class DictionartInitState extends DictionaryState {}

class SearchDictionaryLoaded extends DictionaryState {
  final List<Dictionary> dictionaryInfo;

  SearchDictionaryLoaded({required this.dictionaryInfo});
}

class SearchDictionaryError extends DictionaryState {
  final String errorMessage;

  SearchDictionaryError({required this.errorMessage});
}

class SearchDictionaryLoading extends DictionaryState {}

class SimilarWordsLoaded extends DictionaryState {
  final GenerateContentResponse dictionaryInfo;

  SimilarWordsLoaded({required this.dictionaryInfo});
}

class SimilarWordsError extends DictionaryState {
  final String errorMessage;

  SimilarWordsError({required this.errorMessage});
}

class SimilarWordsLoading extends DictionaryState {}

class SearchWordMeaningLoaded extends DictionaryState {
  final Dictionary dictionaryInfo;
  final String? dateTime;

  SearchWordMeaningLoaded({
    required this.dictionaryInfo,
    required this.dateTime,
  });
}

class SearchWordMeaningError extends DictionaryState {
  final String errorMessage;

  SearchWordMeaningError({required this.errorMessage});
}

class SearchWordMeaningLoading extends DictionaryState {}

class InterstatialAdLoaded extends DictionaryState {
  final InterstitialAd? ad;

  InterstatialAdLoaded({required this.ad});
}

class InterstatialAdLoadError extends DictionaryState {
  final String errorMessage;

  InterstatialAdLoadError({required this.errorMessage});
}

class InterstatialAdLoading extends DictionaryState {}
