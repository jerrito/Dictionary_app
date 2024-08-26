import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/database/entity/phonetic_type_conveter.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';


@entity
class DatabaseDictionary extends Equatable {
  @primaryKey
  final int? id;
  final Dictionary dictionaryConveter;

  const DatabaseDictionary({
    this.id,
    required this.dictionaryConveter,
  });

  @override
  List<Object?> get props => [
        id,
        dictionaryConveter,
      ];
}
