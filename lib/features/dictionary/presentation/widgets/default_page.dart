import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/assets/images.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/dictionary_scanner_widget.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/searched_words.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/show_meaning_modal.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({
    super.key,
    required this.controller,
    required this.dictionaryBloc,
    required this.words,
    this.dictionaryOnTap,
  });
  final ScrollController controller;
  final DictionaryBloc dictionaryBloc;
  final List<String>? words;
  final VoidCallback? dictionaryOnTap;

  @override
  Widget build(BuildContext context) {
    return Column(
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
              onTap: dictionaryOnTap,
            ),
            const DictionaryScannerWidget(
              label: "Scan words",
              image: DictionaryImages.scannerImage,
              color: DictionaryColors.success300,
              onTap: null,
            )
          ],
        ),
        Space.height(context, 0.02),
        if (words?.isNotEmpty ?? false)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Search History",
              ),
              GestureDetector(
                  onTap: clearAllHistory,
                  child: Text(
                    "Clear all",
                  )),
            ],
          ),
        Column(
          spacing: Sizes.height(context, 0.012),
          children: List.generate(
              (words?.length ?? 0) > 8 ? 8 : words?.length ?? 0, (index) {
            print(words?[index]);

            return SearchedWordsWidget(
              wordTitle: words?[index] ?? "",
              onTap: () async {
                final response =
                    await dictionaryBloc.getResponse(words?[index] ?? "");

                // final result = DictionaryModel.fromJson(
                //     response!.dictionary);
                if (!context.mounted) return;
                await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    scrollControlDisabledMaxHeightRatio: ScrollDragController
                        .momentumRetainVelocityThresholdFactor,
                    builder: (context) {
                      return ShowMeaningModal(
                          dictionary:
                              DictionaryModel.fromJson(response?.dictionary));
                    });
                // print(result.meanings);
              },
            );
          }),
        )
      ],
    );
  }

  Future clearAllHistory() async {
    // dictionaryBloc.deleteDictionaryList(list);
  }
}
