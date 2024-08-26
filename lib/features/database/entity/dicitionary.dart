import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';

@entity
class DictionaryResponse extends Equatable {
  @primaryKey
  final int? id;
  final Dictionary dictionary;

  const DictionaryResponse({
    this.id,
    required this.dictionary,
  });

  @override
  List<Object?> get props => [
        id,
        dictionary,
      ];
}
