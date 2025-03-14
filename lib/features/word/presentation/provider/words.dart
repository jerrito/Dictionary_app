import 'package:flutter/widgets.dart';

class WordsProvider extends ChangeNotifier {
  Map<dynamic, dynamic>? _words;
  bool? _hasWords;

  bool get hasWords => _hasWords ?? false;
  //  Map<String,String>? wor

  Map<dynamic, dynamic>? get words => _words;

  set words(Map<dynamic, dynamic>? words) {
    _words = words;
    notifyListeners();
  }

  set hasWords(bool? hasWords) {
    _hasWords = hasWords;
    notifyListeners();
  }
}
