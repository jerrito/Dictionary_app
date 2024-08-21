
part of 'dictionary_bloc.dart';

sealed class DictionaryEvent {}

class SearchDictionaryEvent extends DictionaryEvent {
  final Map<String, dynamic> params;

  SearchDictionaryEvent({required this.params});
}
