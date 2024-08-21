import 'package:riverpod_learn/features/dictionary/domain/entities/phonetics.dart';

class PhoneticsModel extends Phonetics {
  const PhoneticsModel({
    required super.text,
    required super.audio,
  });

  factory PhoneticsModel.fromJson(Map<String, dynamic>? json) => PhoneticsModel(
        text: json?["text"],
        audio: json?["audio"],
      );
}
