import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/onboarding/first_page.dart';
import 'package:riverpod_learn/core/onboarding/second_page.dart';

class OnboardingPageViews extends StatefulWidget {
  const OnboardingPageViews({super.key});

  @override
  State<OnboardingPageViews> createState() => _OnboardingPageViewsState();
}

class _OnboardingPageViewsState extends State<OnboardingPageViews> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return PageView(
      // reverse: true,
      children: const [
        OnboardingPage(
          index: 0,
        ),
        SecondOnboardingPage(
          index: 1,
        ),
      ],
    );
  }
}
