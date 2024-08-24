import 'package:equatable/equatable.dart';

class DictionaryError extends Equatable {
  final String? title, message, resolution;

  const DictionaryError({
    required this.title,
    required this.message,
    required this.resolution,
  });

  @override
  List<Object?> get props => [
        title,
        message,
        resolution,
      ];
}
