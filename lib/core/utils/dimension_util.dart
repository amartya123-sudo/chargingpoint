import 'package:flutter/material.dart';

class DimensionUtil {
  static double height(BuildContext context, double height) {
    return height * MediaQuery.of(context).size.height;
  }

  static double width(BuildContext context, width) {
    return width * MediaQuery.of(context).size.width;
  }
}
