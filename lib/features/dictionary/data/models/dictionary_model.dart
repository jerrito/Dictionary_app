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
    required super.dateTime,
  });

  factory DictionaryModel.fromJson(Map<dynamic, dynamic>? json) =>
      DictionaryModel(
        word: json?["word"],
        phonetic: json?["phonetic"],
        origin: json?["origin"],
        phonetics: json?["phonetics"] != null
            ? List<PhoneticsModel>.from(
                json?["phonetics"].map(
                  (e) => PhoneticsModel.fromJson(e),
                ),
              )
            : null,
        meanings: json?["meanings"] != null
            ? List<MeaningModel>.from(
                json?["meanings"].map(
                  (e) => MeaningModel.fromJson(e),
                ),
              )
            : null,
        dateTime: DateTime.now().toIso8601String(),
      );

  //to map

  @override
  Map<String, dynamic> toMap() => {
        "word": word,
        "phonetic": phonetic,
        "origin": origin,
        "dateTime": dateTime,
        'phonetics': phonetics?.map((e) => e.toJson()).toList(),
        'meanings': meanings?.map((e) => e.toJson()).toList(),
      };
}
