import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class WordPhonetic extends StatelessWidget {
  const WordPhonetic({
    super.key,
    required this.word,
    this.phonetic,
    this.onSoundTap,
    required this.hasSound,
  });
  final String word;
  final String? phonetic;
  final VoidCallback? onSoundTap;
  final bool hasSound;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          word,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Space.height(context, 0.012),
        if (phonetic != null || hasSound)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              color: context.themeData.brightness == Brightness.dark
                  ? DictionaryColors.primary400
                  : DictionaryColors.primary25,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: context.themeData.brightness == Brightness.dark
                      ? DictionaryColors.primary300
                      : DictionaryColors.primary100,
                ),
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (phonetic != null)
                  Text(
                    phonetic!,
                    style: TextStyle(
                      fontSize: 16,
                      color: context.themeData.brightness != Brightness.dark
                          ? DictionaryColors.primaryBase
                          : DictionaryColors.whiteBackground,
                    ),
                  ),
                const SizedBox(width: 8),
                if (hasSound)
                  GestureDetector(
                    onTap: onSoundTap,
                    child: const Icon(
                      Icons.volume_up,
                      size: 20,
                      color: DictionaryColors.secondary400,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
