import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/extensions.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';
import 'package:riverpod_learn/core/themes/colors.dart';

class DefinitionWidget extends StatelessWidget {
  final String index, partOfSpeech;
  final List<Widget> definition;
  final bool? isNew;
  final String? image;
  const DefinitionWidget({
    super.key,
    required this.index,
    required this.partOfSpeech,
    required this.definition,
    this.isNew,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: Sizes.height(
        context,
        0.01,
      )),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: DictionaryColors.primary100,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isNew ?? false
              ? _NewPartsOfSpeech(
                  partOfSpeech: partOfSpeech,
                  image: image,
                )
              : Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$index.",
                      style: const TextStyle(fontSize: 20),
                    ),
                    Space.width(context, 0.01),
                    _PartOfSpeech(
                      partOfSpeech: partOfSpeech,
                    ),
                  ],
                ),
          Space.height(context, 0.01),
          Padding(
            padding: EdgeInsets.only(
              left: Sizes.height(context, 0.025),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: definition),
          )
        ],
      ),
    );
  }
}

class _PartOfSpeech extends StatelessWidget {
  final String partOfSpeech;
  const _PartOfSpeech({required this.partOfSpeech});

  @override
  Widget build(BuildContext context) {
    return partOfSpeech.isNotEmpty
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.width(
                context,
                0.025,
              ),
              vertical: Sizes.height(
                context,
                0.003,
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.height(
                  context,
                  0.01,
                )),
                color: const Color.fromARGB(188, 36, 36, 179)),
            child: Text(
              partOfSpeech,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        : const SizedBox.shrink();
  }
}

class _NewPartsOfSpeech extends StatelessWidget {
  const _NewPartsOfSpeech({required this.partOfSpeech, this.image});
  final String partOfSpeech;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return partOfSpeech.isNotEmpty
        ? Container(
            padding: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: DictionaryColors.primary100,
              ),
            )),
            child: Row(
              spacing: 10,
              children: [
                Image.asset(
                  height: Sizes.height(context, 0.024),
                  width: Sizes.width(context, 0.048),
                  image ?? "",
                ),
                Text(
                  partOfSpeech,
                  style: TextStyle(
                    color: context.themeData.brightness == Brightness.dark
                        ? DictionaryColors.whiteBackground
                        : DictionaryColors.blackBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
