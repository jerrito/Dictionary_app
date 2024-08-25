import 'package:equatable/equatable.dart';

class Phonetics extends Equatable {
  final String? text, audio;

  const Phonetics({
    required this.text,
    required this.audio,
  });

  @override
  List<Object?> get props => [text, audio];
}
