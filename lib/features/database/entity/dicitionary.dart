import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class DictionaryResponse extends Equatable {
  @primaryKey
  final int? id;
  final String word;
  final String dictionary;

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
