import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late Orientation orientation;

  static void init(BuildContext context) {
    screenWidth = context.mediaQuerySize.width;
    screenHeight = context.mediaQuerySize.height;
    orientation = context.orientation;
  }
}

// !Get the proportionate height as per screen size
double getProportionateTaskHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // !812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// !Get the proportionate height as per screen size
double getProportionateTaskWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // !375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
