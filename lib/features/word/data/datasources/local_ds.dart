import 'package:shared_preferences/shared_preferences.dart';

abstract class WordLocalDatasource {
  Future<List<dynamic>> suggestWords({
    required Map<String, dynamic> params,
  });
  Future<bool> saveWord(Map<String, dynamic> params);
  Future<List<String>?> retrieveSavedWords(Map<String, dynamic> params);
}

class WordLocalDatasourceImpl implements WordLocalDatasource {
  final SharedPreferences sharedPreferences;

  WordLocalDatasourceImpl({required this.sharedPreferences});
  final saveWordKey = "saveWordKey";
  @override
  Future<List<dynamic>> suggestWords(
      {required Map<String, dynamic> params}) async {
    List<dynamic> myList = [];
    final Map<dynamic, dynamic> decodedWords = params["decodedWords"];
    // myList.addAll(decodedWords.keys.where((e) => e.startsWith(params["text"])));

    final lis = List<String>.from(
        decodedWords.keys.where((e) => e.startsWith(params["text"])));
    print(lis);

    return lis;
  }

  @override
  Future<List<String>?> retrieveSavedWords(Map<String, dynamic> params) async {
    try {
      final words = sharedPreferences.getStringList(saveWordKey);

      return words;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<bool> saveWord(Map<String, dynamic> params) async {
    final get = await retrieveSavedWords(params);
    if (get!.contains(params["word"]) || get.isEmpty) {
      return false;
    }
    get.add(params["word"]);
    sharedPreferences.setStringList(saveWordKey, get);
    return true;
  }
}
