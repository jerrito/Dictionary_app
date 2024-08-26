import 'package:flutter/material.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';

class DefinitionWidget extends StatelessWidget {
  final String index, partOfSpeech;
  final List<Widget> definition;
  const DefinitionWidget({
    super.key,
    required this.index,
    required this.partOfSpeech,
    required this.definition,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Sizes.height(
          context,
          0.01,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$index.",
                style: const TextStyle(fontSize: 20),
              ),
              Space.width(context, 0.01),
              PartOfSpeech(
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
              children:definition
            ),
          )
        ],
      ),
    );
  }
}

class PartOfSpeech extends StatelessWidget {
  final String partOfSpeech;
  const PartOfSpeech({super.key, required this.partOfSpeech});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
