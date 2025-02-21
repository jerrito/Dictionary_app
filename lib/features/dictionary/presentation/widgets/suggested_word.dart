import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class SuggestedWord extends StatelessWidget {
  const SuggestedWord({super.key, required this.word, required this.onTap});
  final String word;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Sizes.height(
            context,
            0.01,
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? DictionaryColors.primary400
                  : DictionaryColors.primary100,
            ),
          ),
        ),
        child: Text(
          word,
          style: context.themeData.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
