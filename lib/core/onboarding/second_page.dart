import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/assets/images.dart';
import 'package:riverpod_learn/core/onboarding/default_page.dart';

class SecondOnboardingPage extends StatelessWidget {
  const SecondOnboardingPage({
    super.key,
    required this.index,
    this.onPressed,
  });
  final int index;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return DefaultOnboardingPage(
      onPressed: onPressed,
      isActive: index,
      buttonLabel: "Let's get started",
      firstLabel: "Quick and offline access",
      secondLabel:
          "Find searched words anytime, anywhere, without the internet",
      image: DictionaryImages.onboardingImage2,
    );
  }
}
