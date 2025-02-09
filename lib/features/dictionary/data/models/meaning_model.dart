import 'package:riverpod_learn/features/dictionary/domain/entities/meanings.dart';

class MeaningModel extends Meanings {
  const MeaningModel({
    required super.partOfSpeech,
    required super.definitions,
    required super.antonyms,
    required super.synonyms,
  });

  factory MeaningModel.fromJson(Map<String, dynamic>? json) => MeaningModel(
        partOfSpeech: json?["partOfSpeech"],
        definitions: json?["definitions"] != null
            ? List<DefinitionsModel>.from(
                json?["definitions"].map((e) => DefinitionsModel.fromJson(e)),
              )
            : null,
        antonyms: json?["antonyms"] != null
            ? List<String>.from(
                json?["antonyms"].map((e) => e),
              )
            : null,
        synonyms: json?["synonyms"] != null
            ? List<String>.from(
                json?["synonyms"].map((e) => e),
              )
            : null,
      );
}

class DefinitionsModel extends Definitions {
  const DefinitionsModel({
    required super.definition,
    required super.example,
  });

  factory DefinitionsModel.fromJson(Map<String, dynamic>? json) =>
      DefinitionsModel(
        definition: json?["definition"],
        example: json?["example"],
      );
}
