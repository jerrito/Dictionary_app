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
    return Container(

      child: ListView.builder(
          itemCount: dictionary.meanings?.length,
          itemBuilder: (context, index) {
            final meanings = dictionary.meanings?[index];
            return DefinitionWidget(
              index: "${index + 1}",
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
                              definition:
                                  meanings.definitions?[index].definition,
                            ),
                            ExampleRow(
                              isExample:
                                  meanings.definitions?[index].example != null,
                              example: meanings.definitions?[index].example,
                            )
                          ],
                        ),
                      )),
            );
          }),
    );
  }
}
