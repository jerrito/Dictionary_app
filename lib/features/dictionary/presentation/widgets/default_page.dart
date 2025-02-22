import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/assets/images.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/dictionary_scanner_widget.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({
    super.key,
    required this.controller,
  });
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        spacing: Sizes.height(context, 0.02),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: Sizes.width(context, 0.04),
            children: [
              DictionaryScannerWidget(
                label: "Dictionary (A-Z)",
                image: DictionaryImages.dictionary,
                color: DictionaryColors.warning300,
                onTap: () => print("object"),
              ),
              const DictionaryScannerWidget(
                label: "Scan words",
                image: DictionaryImages.scannerImage,
                color: DictionaryColors.success300,
                onTap: null,
              )
            ],
          )
        ],
      ),
    );
  }
}
