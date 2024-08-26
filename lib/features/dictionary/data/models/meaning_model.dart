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
      definitions: List<DefinitionsModel>.from(
        json?["definitions"].map((e) => DefinitionsModel.fromJson(e)),
        
      ),
       antonyms: List<String>.from(
          json?["antonyms"].map((e) => e),
        ),
        synonyms: List<String>.from(
          json?["synonyms"].map((e) => e),
        ),
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
