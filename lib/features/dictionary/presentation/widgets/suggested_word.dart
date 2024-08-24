import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/size.dart';

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
            0.02,
          ),
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        child: Text(
          word,
          style: const TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
