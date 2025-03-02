import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:riverpod_learn/core/assets/images.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/themes/colors.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/dictionary/data/models/dictionary_model.dart';
import 'package:riverpod_learn/features/dictionary/presentation/bloc/dictionary_bloc.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/dictionary_scanner_widget.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/searched_words.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/show_meaning_modal.dart';
import 'package:riverpod_learn/features/word/presentation/bloc/word_bloc.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({
    super.key,
    required this.controller,
    required this.dictionaryBloc,
    required this.wordBloc,
    required this.words,
    this.dictionaryOnTap,
  });
  final ScrollController controller;
  final DictionaryBloc dictionaryBloc;
  final WordBloc wordBloc;
  final List<String>? words;
  final VoidCallback? dictionaryOnTap;

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  Future<void> scanWord() async {
    InputImage? inputImage;
    final RecognizedText recognizedText =
        await textRecognizer.processImage(InputImage.fromFile(File("path")));

    String text = recognizedText.text;
    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
          print(element.text);
        }
      }
    }
  }

  @override
  void initState() {
    // inputImage = InputImage();
    // TODO: implement initState
    super.initState();
  }
  // textRecognizer.close();

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
              onTap: widget.dictionaryOnTap,
            ),
            DictionaryScannerWidget(
              label: "Scan words",
              image: DictionaryImages.scannerImage,
              color: DictionaryColors.success300,
              onTap: scanWord,
            )
          ],
        ),
        Space.height(context, 0.02),
        if (widget.words?.isNotEmpty ?? false)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Search History",
              ),
              GestureDetector(
                  onTap: () async {
                    final clear = await clearAllHistory();
                    if (clear) {
                      widget.wordBloc.add(
                        DeleteWordEvent(
                          words: widget.words ?? [],
                        ),
                      );
                      print("ss");
                    }
                  },
                  child: const Text(
                    "Clear all",
                  )),
            ],
          ),
        Column(
          spacing: Sizes.height(context, 0.012),
          children: List.generate(
              (widget.words?.length ?? 0) > 8 ? 8 : widget.words?.length ?? 0,
              (index) {
            return SearchedWordsWidget(
              wordTitle: widget.words?[index] ?? "",
              onTap: () async {
                final response = await widget.dictionaryBloc
                    .getResponse(widget.words?[index] ?? "");

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

  Future<bool> clearAllHistory() async {
    List<DictionaryResponse>? responses = [];
    for (var word in widget.words ?? []) {
      final response = await widget.dictionaryBloc.getResponse(word ?? "");
      if (response != null) {
        responses.add(response);
      }
    }
    print(responses);
    final response =
        await widget.dictionaryBloc.deleteDictionaryList(responses);
    print(response);
    return response;
  }
}
