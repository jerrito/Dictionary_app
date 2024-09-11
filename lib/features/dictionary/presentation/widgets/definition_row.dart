import 'package:flutter/material.dart';
import 'package:numerus/roman/roman.dart';
import 'package:riverpod_learn/core/size.dart';
import 'package:riverpod_learn/core/space.dart';

class DefinitionRow extends StatelessWidget {
  final int index;
  final String? definition;
  const DefinitionRow({
    super.key,
    required this.index,
    this.definition,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${(index + 1).toRomanNumeralString()}.",
          style: const TextStyle(fontSize: 18),
        ),
        Space.width(context, 0.01),
        SizedBox(
          width: Sizes.width(context, 0.78),
          child: Text(
            definition ?? "",
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

class ExampleRow extends StatelessWidget {
  final bool isExample;
  final String? example;
  const ExampleRow({
    super.key,
    required this.isExample,
    this.example,
  });

  @override
  Widget build(BuildContext context) {
    return isExample
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Eg.",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Space.width(context, 0.01),
              SizedBox(
                width: Sizes.width(context, 0.78),
                child: Text(
                  example ?? "",
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
