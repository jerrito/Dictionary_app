import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/size.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.onPressed,
  });
  final String label;
  final Color? backgroundColor, textColor;
  final double? borderRadius;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: Sizes.height(context, 0.055),
        width: double.infinity,
        decoration: BoxDecoration(
            color: context.themeData.brightness == Brightness.light
                ? Colors.black
                : Colors.white,
            borderRadius: BorderRadius.circular(
              Sizes.height(
                context,
                0.1,
              ),
            )),
        child: Center(
          child: Text(label,
              style: TextStyle(
                  color: context.themeData.brightness != Brightness.light
                      ? Colors.black
                      : Colors.white,
                  fontSize: 18)),
        ),
      ),
    );
  }
}
