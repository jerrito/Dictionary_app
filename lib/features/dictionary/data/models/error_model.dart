import 'package:riverpod_learn/features/dictionary/domain/entities/error.dart';

class DictionaryErrorModel extends DictionaryError {
  const DictionaryErrorModel({
    required super.title,
    required super.message,
    required super.resolution,
  });

  // fromJson
  factory DictionaryErrorModel.fromJson(Map<String, dynamic>? json) =>
      DictionaryErrorModel(
        title: json?["title"],
        message: json?["message"],
        resolution: json?["resolution"],
      );
}
