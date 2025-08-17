import 'package:flutter/material.dart';

class ResponsiveConstants {
  // Screen width function
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  // Screen height function
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}