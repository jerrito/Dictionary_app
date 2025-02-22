import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:riverpod_learn/core/assets/images.dart';
import 'package:riverpod_learn/core/assets/svgs.dart';
import 'package:riverpod_learn/core/size.dart';

class SearchedWordsWidget extends StatelessWidget {
  const SearchedWordsWidget({
    super.key,
    required this.wordTitle,
    this.onTap,
  });
  final String wordTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Sizes.height(context, 0.016),
            vertical: Sizes.height(context, 0.01)),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.height(
              context,
              0.01,
            ))),
            shadows: const [BoxShadow()]),
        child: Column(
          spacing: Sizes.height(context, 0.012),
          children: [
            _FirstRow(true, wordTitle),
            // Consumer(builder: builder)
            _LastRow("duration"),
          ],
        ),
      ),
    );
  }
}

class _FirstRow extends StatelessWidget {
  const _FirstRow(
    this.hasAudio,
    this.wordTitle,
  );
  final bool? hasAudio;
  final String wordTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: Sizes.width(context, 0.01),
          children: [
            Text(
              wordTitle,
            ),
            SvgPicture.asset(DictionarySvgs.volumeSVG)
          ],
        ),
        SvgPicture.asset(DictionarySvgs.moreHorizontalSVG)
      ],
    );
  }
}

class _LastRow extends StatelessWidget {
  const _LastRow(
    this.duration,
  );
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: Sizes.width(context, 0.01),
          children: [
            SvgPicture.asset(DictionarySvgs.timeSVG),
            Text(
              duration,
            ),
          ],
        ),
        const Icon(Icons.arrow_forward_sharp)
      ],
    );
  }
}
