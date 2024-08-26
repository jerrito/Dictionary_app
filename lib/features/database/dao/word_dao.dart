import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/database/entity/phonetic_type_conveter.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';

@dao
abstract class WordDao {
  @insert
  Future<void> insertData(DatabaseDictionary dictionary);
}
