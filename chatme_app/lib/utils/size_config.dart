import 'package:flutter/material.dart';

class SizeConfig {
  //---get the screen height
  static double h(BuildContext context) => MediaQuery.of(context).size.height;

  //---get the screen width
  static double w(BuildContext context) => MediaQuery.of(context).size.width;
}
