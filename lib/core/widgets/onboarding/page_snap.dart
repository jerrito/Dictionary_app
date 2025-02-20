import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/size.dart';

class PageSnap extends StatelessWidget {
  const PageSnap({super.key, required this.isActive});
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          isActive ? Sizes.width(context, 0.033) : Sizes.width(context, 0.016),
      height: isActive
          ? Sizes.height(context, 0.008)
          : Sizes.height(context, 0.008),
      decoration: ShapeDecoration(
        shape: isActive
            ? const StadiumBorder()
            : RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(Sizes.height(context, 0.1))),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    );
  }
}
