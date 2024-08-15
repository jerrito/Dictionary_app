import 'package:equatable/equatable.dart';
import 'package:riverpod_learn/features/movies/domain/entities/meanings.dart';
import 'package:riverpod_learn/features/movies/domain/entities/phonetics.dart';

// {
//     "word": "hello",
//     "phonetic": "həˈləʊ",
//     "phonetics": [
//       {
//         "text": "həˈləʊ",
//         "audio": "//ssl.gstatic.com/dictionary/static/sounds/20200429/hello--_gb_1.mp3"
//       },
//       {
//         "text": "hɛˈləʊ"
//       }
//     ],
//     "origin": "early 19th century: variant of earlier hollo ; related to holla.",
//     "meanings": [
//       {
//         "partOfSpeech": "exclamation",
//         "definitions": [
//           {
//             "definition": "used as a greeting or to begin a phone conversation.",
//             "example": "hello there, Katie!",
//             "synonyms": [],
//             "antonyms": []
//           }
//         ]
//       },
class Dictionary extends Equatable {
  final String? word, phonetic, origin;
  final List<Phonetics>? phonetics;
  final List<Meanings>? meanings;

  const Dictionary({
    required this.word,
    required this.phonetic,
    required this.origin,
    required this.phonetics,
    required this.meanings,
  });

  @override
  List<Object?> get props => [
        word,
        phonetic,
        origin,
        phonetics,
        meanings,
      ];
}
