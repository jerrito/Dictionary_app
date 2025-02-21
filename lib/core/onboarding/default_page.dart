import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/assets/images.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/widgets/buttons/default_button.dart';
import 'package:riverpod_learn/core/widgets/onboarding/onboarding_text.dart';
import 'package:riverpod_learn/core/widgets/onboarding/page_snap.dart';

class DefaultOnboardingPage extends StatelessWidget {
  const DefaultOnboardingPage({
    super.key,
    required this.buttonLabel,
    required this.firstLabel,
    required this.secondLabel,
    required this.image,
    required this.isActive,
    this.onPressed,
  });
  final String buttonLabel, firstLabel, secondLabel, image;
  final int isActive;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: Sizes.width(context, 0.02)),
        color: Colors.transparent,
        margin: EdgeInsets.only(bottom: Sizes.height(context, 0.03)),
        child: DefaultButton(
          label: buttonLabel,
          onPressed: onPressed,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.width(context, 0.02)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: double.infinity,
              height: Sizes.height(
                context,
                0.302,
              ),
            ),
            Space.height(
              context,
              0.024,
            ),
            OnboardingText(firstLabel: firstLabel, secondLabel: secondLabel),
            Space.height(
              context,
              0.024,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Sizes.width(context, 0.008),
              children: [
                PageSnap(isActive: isActive == 0),
                PageSnap(isActive: isActive == 1),
              ],
            )
          ],
        ),
      ),
    );
  }
}
