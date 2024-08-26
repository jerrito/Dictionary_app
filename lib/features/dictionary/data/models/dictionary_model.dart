import 'package:riverpod_learn/features/dictionary/data/models/meaning_model.dart';
import 'package:riverpod_learn/features/dictionary/data/models/phonetics_model.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';

class DictionaryModel extends Dictionary {
  const DictionaryModel({
    required super.word,
    required super.phonetic,
    required super.origin,
    required super.phonetics,
    required super.meanings,
  });

  factory DictionaryModel.fromJson(Map<String, dynamic>? json) =>
      DictionaryModel(
        word: json?["word"],
        phonetic: json?["phonetic"],
        origin: json?["origin"],
        phonetics: List<PhoneticsModel>.from(
          json?["phonetics"].map(
            (e) => PhoneticsModel.fromJson(e),
          ),
        ),
        meanings: List<MeaningModel>.from(
          json?["meanings"].map(
            (e) => MeaningModel.fromJson(e),
          ),
        ),
      );

}
