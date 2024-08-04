import 'package:flutter/material.dart';

double height(BuildContext context,double height) {
  return height * MediaQuery.of(context).size.height;
}

double width(BuildContext context, width) {
  return width * MediaQuery.of(context).size.width;
}