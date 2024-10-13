part of 'dictionary_bloc.dart';

sealed class DictionaryEvent {}

class SearchDictionaryEvent extends DictionaryEvent {
  final Map<String, dynamic> params;

  SearchDictionaryEvent({required this.params});
}

class LoadAdEvent extends DictionaryEvent {
  LoadAdEvent();
}

class AdSuccessEvent extends DictionaryEvent {
  final InterstitialAd? ad;
  AdSuccessEvent({required this.ad});
}


class AdFailedEvent extends DictionaryEvent {
  final String? errorMessage;
  AdFailedEvent({required this.errorMessage});
}
