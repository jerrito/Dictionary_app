import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_learn/core/assets/svgs.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class NewResultAppBar extends StatelessWidget {
  const NewResultAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const _CancelButton(),
        Row(
          spacing: Sizes.width(
            context,
            0.04,
          ),
          children: [
            SVGWidget(
              onTap: () => print("object"),
              svg: DictionarySvgs.bookmarkSVG,
            ),
            const SVGWidget(
              svg: DictionarySvgs.shareSVG,
            ),
            const SVGWidget(
              svg: DictionarySvgs.moreSVG,
            ),
          ],
        )
      ],
    );
  }
}

class SVGWidget extends StatelessWidget {
  const SVGWidget({
    super.key,
    required this.svg,
    this.onTap,
  });
  final String svg;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        svg,
        colorFilter: ColorFilter.mode(
          context.themeData.brightness != Brightness.dark
              ? DictionaryColors.blackBackground
              : DictionaryColors.darkShadow,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Icon(
        size: 30,
        weight: 0.1,
        fill: 0.1,
        Icons.cancel,
        color: context.themeData.brightness != Brightness.dark
            ? DictionaryColors.blackBackground
            : DictionaryColors.darkShadow,
      ),
    );
  }
}
