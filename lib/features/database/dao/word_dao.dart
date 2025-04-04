import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';

@dao
abstract class WordDao {
  @insert
  Future<void> insertData(DictionaryResponse response);
  @insert
  Future<void> insertBookmarkData(DictionaryBookmarkResponse response);

  @Query("SELECT * FROM DictionaryResponse")
  Stream<List<DictionaryResponse>> getList();

  @Query("SELECT * FROM DictionaryBookmarkResponse")
  Stream<List<DictionaryBookmarkResponse>> getBookmarkList();

  @Query("SELECT * FROM DictionaryResponse")
  Future<List<DictionaryResponse>> getAll();

  @Query("SELECT * FROM DictionaryBookmarkResponse")
  Future<List<DictionaryBookmarkResponse>> getAllBookmark();

  @delete
  Future<void> deleteDictionaryResponse(DictionaryResponse response) async {}

  @delete
  Future<void> deleteBookmarkDictionaryResponse(
      DictionaryBookmarkResponse response) async {}

  @delete
  Future<void> deleteListDictionaryResponse(List<DictionaryResponse> list);

  @delete
  Future<void> deleteListDictionaryBookmarkResponse(
      List<DictionaryBookmarkResponse> list);

  @Query("SELECT * FROM DictionaryResponse WHERE word= :word ")
  Future<DictionaryResponse?> getDictionaryResponse(String word);

  @Query("SELECT * FROM DictionaryBookmarkResponse WHERE word= :word ")
  Future<DictionaryBookmarkResponse?> getDictionaryBookmarkResponse(
      String word);
}
