import 'package:equatable/equatable.dart';

class Meanings extends Equatable {
  final String? partOfSpeech;
  final List<Definitions>? definitions;

  const Meanings({
    required this.partOfSpeech,
    required this.definitions,
  });

  @override
  List<Object?> get props => [
        partOfSpeech,
        definitions,
      ];
}

class Definitions extends Equatable {
  final String? definition, example;
  final List<dynamic>? synonyms, antonyms;

  const Definitions({
    required this.definition,
    required this.example,
    required this.antonyms,
    required this.synonyms,
  });

  @override
  List<Object?> get props => [
        definition,
        example,
        synonyms,
        antonyms,
      ];
}
