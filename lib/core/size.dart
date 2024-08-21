import 'package:flutter/material.dart';

class Sizes {
  Sizes._();

  //height definition
  static double height(BuildContext context, double size) {
    return MediaQuery.sizeOf(context).height * size;
  }

  // width definition
  static double width(BuildContext context, double size) {
    return MediaQuery.sizeOf(context).width * size;
  }
}
