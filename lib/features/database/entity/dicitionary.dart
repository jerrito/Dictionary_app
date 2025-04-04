import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class DictionaryResponse extends Equatable {
  @primaryKey
  final int? id;
  final String word;
  final String dateTime;
  final Map<dynamic, dynamic>? dictionary;

  const DictionaryResponse({
    required this.dateTime,
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

@entity
class DictionaryBookmarkResponse extends Equatable {
  @primaryKey
  final int? id;
  final String word;
  final String dateTime;
  final Map<dynamic, dynamic>? dictionary;

  const DictionaryBookmarkResponse({
    this.id,
    required this.word,
    required this.dictionary,
    required this.dateTime,
  });

  @override
  List<Object?> get props => [
        id,
        word,
        dictionary,
      ];
}
