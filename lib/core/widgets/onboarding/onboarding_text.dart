import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/size.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({
    super.key,
    required this.firstLabel,
    required this.secondLabel,
  });
  final String firstLabel, secondLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Sizes.height(context, 0.008),
      children: [
        Text(
          firstLabel,
          style: context.themeData.textTheme.displaySmall
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        Text(
          secondLabel,
          textAlign: TextAlign.center,
          style: context.themeData.textTheme.bodyMedium?.copyWith(
            // color: Colors.black26,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
