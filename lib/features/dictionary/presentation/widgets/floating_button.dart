import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class FloatingSearchButton extends StatelessWidget {
  const FloatingSearchButton({
    super.key,
    required this.hasJobs,
    required this.onTap,
  });
  final bool hasJobs;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !hasJobs,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? DictionaryColors.blackBackground
                : DictionaryColors.primary50,
            borderRadius: BorderRadius.circular(5),
          ),
          height: Sizes.height(context, 0.04),
          width: Sizes.height(context, 0.04),
          child: Icon(
            color: Theme.of(context).brightness != Brightness.light
                ? DictionaryColors.blackBackground
                : DictionaryColors.primary50,
            Icons.arrow_upward_rounded,
          ),
        ),
      ),
    );
  }
}
