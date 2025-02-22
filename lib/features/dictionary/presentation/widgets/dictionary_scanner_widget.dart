import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class DictionaryScannerWidget extends StatelessWidget {
  const DictionaryScannerWidget({
    super.key,
    required this.label,
    required this.image,
    this.onTap,
    this.color,
  });
  final String label, image;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(
              Sizes.height(context, 0.01),
            )),
        width: Sizes.width(context, 0.43),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: Sizes.width(
            context,
            0.02,
          ),
          vertical: Sizes.height(context, 0.01),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.height(
            context,
            0.02,
          ),
          children: [
            Image.asset(
              image,
              height: Sizes.height(context, 0.05),
              width: Sizes.width(context, 0.1),
            ),
            Text(
              label,
              style: context.themeData.textTheme.bodyMedium
                  ?.copyWith(color: DictionaryColors.primary300),
            )
          ],
        ),
      ),
    );
  }
}
