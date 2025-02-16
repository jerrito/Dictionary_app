import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/features/dictionary/domain/entities/dictionary.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/definition_row.dart';
import 'package:riverpod_learn/features/dictionary/presentation/widgets/definition_widget.dart';

class ShowMeaningModal extends StatelessWidget {
  final Dictionary dictionary;
  const ShowMeaningModal({
    super.key,
    required this.dictionary,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
          child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: dictionary.meanings?.isNotEmpty ?? false
                  ? List.generate(dictionary.meanings!.length, (ins) {
                      // final index=ins?.length ?? 0;
                      final meanings = dictionary.meanings?[ins];
                      return DefinitionWidget(
                        index: "${ins + 1}",
                        partOfSpeech: meanings?.partOfSpeech ?? "",
                        definition: List.generate(
                            meanings!.definitions!.length,
                            (int index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: Sizes.height(context, 0.01)),
                                  child: Column(
                                    children: [
                                      DefinitionRow(
                                        index: index,
                                        definition: meanings
                                            .definitions?[index].definition,
                                      ),
                                      ExampleRow(
                                        isExample: meanings
                                                .definitions?[index].example !=
                                            null,
                                        example: meanings
                                            .definitions?[index].example,
                                      )
                                    ],
                                  ),
                                )),
                      );
                    }).toList()
                  : []),
        ),
      ),
    );
  }
}
