import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/images.dart';
import 'package:riverpod_learn/core/onboarding/default_page.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.index,
  });
  final int index;

  @override
  Widget build(BuildContext context) {
    return DefaultOnboardingPage(
        isActive: index,
        buttonLabel: "Next",
        firstLabel: "Expand your vocabulary",
        secondLabel:
            "Search any word for clear definitions, hear accurate word pronunciations. ",
        image: DictionaryImages.onboardingImage1);
  }
}
