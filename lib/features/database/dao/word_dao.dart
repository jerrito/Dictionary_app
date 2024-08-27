import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';

@dao
abstract class WordDao {
  @insert
  Future<void> insertData(DictionaryResponse response);

  @Query("SELECT * FROM DictionaryResponse")
  Stream<List<DictionaryResponse>> getList();

@Query("SELECT * FROM DictionaryResponse")
  Future<List<DictionaryResponse>> getAll();


  @delete
  Future<void> deleteDictionaryResponse(DictionaryResponse response) async {}

  @delete
  Future<void> deleteListDictionaryResponse(List<DictionaryResponse> list);

  @Query("SELECT * FROM DictionaryResponse WHERE id= :id ")
  Future<DictionaryResponse?> getDictionaryResponse(int id);
}
