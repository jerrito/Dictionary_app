import 'package:riverpod_learn/features/dictionary/domain/entities/meanings.dart';

class MeaningModel extends Meanings {
  const MeaningModel({
    required super.partOfSpeech,
    required super.definitions,
  });

  factory MeaningModel.fromJson(Map<String, dynamic>? json) => MeaningModel(
      partOfSpeech: json?["partOfSpeech"],
      definitions: List<DefinitionsModel>.from(
        json?["definitions"].map((e) => DefinitionsModel.fromJson(e)),
      ));
}

class DefinitionsModel extends Definitions {
  const DefinitionsModel({
    required super.definition,
    required super.example,
    required super.antonyms,
    required super.synonyms,
  });

  factory DefinitionsModel.fromJson(Map<String, dynamic>? json) =>
      DefinitionsModel(
        definition: json?["definition"],
        example: json?["example"],
        antonyms: List<dynamic>.from(
          json?["antonyms"].map((e) => e),
        ),
        synonyms: List<dynamic>.from(
          json?["synonyms"].map((e) => e),
        ),
      );
}
