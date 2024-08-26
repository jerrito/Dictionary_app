import 'package:flutter/widgets.dart';

class WordsProvider extends ChangeNotifier {
   Map<dynamic,dynamic>? _words;

  Map<dynamic,dynamic>? get words=> _words;


 set words(Map<dynamic,dynamic>? words){
    _words=words;
    notifyListeners();
 }


}