part of 'dictionary_bloc.dart';

sealed class DictionaryEvent {}

class SearchDictionaryEvent extends DictionaryEvent {
  final Map<String, dynamic> params;

  SearchDictionaryEvent({required this.params});
}

class SearchWordMeaningEvent extends DictionaryEvent {
  final String params;

  SearchWordMeaningEvent({required this.params});
}

class InterstatialAdEvent extends DictionaryEvent {
  InterstatialAdEvent();
}

class InterstatialAdSuccessEvent extends DictionaryEvent {
  final InterstitialAd? ad;
  InterstatialAdSuccessEvent({required this.ad});
}

class InterstatialAdFailedEvent extends DictionaryEvent {
  final String? errorMessage;
  InterstatialAdFailedEvent({required this.errorMessage});
}
