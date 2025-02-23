import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/onboarding/first_page.dart';
import 'package:riverpod_learn/core/onboarding/second_page.dart';
import 'package:riverpod_learn/initial_page.dart';

class OnboardingPageViews extends StatefulWidget {
  const OnboardingPageViews({super.key});

  @override
  State<OnboardingPageViews> createState() => _OnboardingPageViewsState();
}

class _OnboardingPageViewsState extends State<OnboardingPageViews> {
  int index = 0;
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      // reverse: true,
      children: [
        OnboardingPage(
            index: 0,
            onPressed: () =>
                // index = 1;
                controller.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear)
            // print(index);

            ),
        SecondOnboardingPage(
          index: 1,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InitialPage(),
            ),
          ),
        ),
      ],
    );
  }
}
