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

class InterstatialAdLoaded extends DictionaryState {
  final InterstitialAd? ad;

  InterstatialAdLoaded({required this.ad});
}

class InterstatialAdLoadError extends DictionaryState {
  final String errorMessage;

  InterstatialAdLoadError({required this.errorMessage});
}

class InterstatialAdLoading extends DictionaryState {}
