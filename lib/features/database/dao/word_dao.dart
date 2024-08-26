import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/database/entity/dictionary_type_conveter.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';

@dao
abstract class WordDao {
  @insert
  Future<void> insertData(DictionaryResponse response);

  @Query("SELECT * FROM DictionaryResponse")
  Stream<List<DictionaryResponse>> getList();

  @delete
  Future<void> deleteDictionaryResponse(DictionaryResponse response) async {}

  @delete
  Future<void> deleteListDictionaryResponse(List<DictionaryResponse> list);

  @Query("SELECT * FROM DictionaryResponse WHERE id= :id ")
  Future<DictionaryResponse?> getDictionaryResponse(int id);
}
