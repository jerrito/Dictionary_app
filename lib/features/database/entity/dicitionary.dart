import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';

@entity
class DictionaryResponse extends Equatable {
  @primaryKey
  final int? id;
  final String word;
  final DictionaryModel dictionary;

  const DictionaryResponse({
    this.id,
    required this.word,
    required this.dictionary,
  });

  @override
  List<Object?> get props => [
        id,
        word,
        dictionary,
      ];
}
