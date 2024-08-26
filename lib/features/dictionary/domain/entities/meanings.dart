import 'package:equatable/equatable.dart';

class Meanings extends Equatable {
  final String? partOfSpeech;
  final List<Definitions>? definitions;
  final List<String>? synonyms, antonyms;

  const Meanings({
    required this.partOfSpeech,
    required this.definitions,
    required this.antonyms,
    required this.synonyms,
  });

  @override
  List<Object?> get props => [
        partOfSpeech,
        definitions,
        synonyms,
        antonyms,
      ];
}

class Definitions extends Equatable {
  final String? definition, example;

  const Definitions({
    required this.definition,
    required this.example,
  });

  @override
  List<Object?> get props => [
        definition,
        example,
      ];
}
