import 'package:flutter/material.dart';

class ResponsiveUtils {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Responsive font sizes
  static double getHeading1(BuildContext context) {
    double width = getWidth(context);
    if (width < 600) return 24;
    if (width < 1100) return 28;
    return 32;
  }

  static double getHeading2(BuildContext context) {
    double width = getWidth(context);
    if (width < 600) return 20;
    if (width < 1100) return 24;
    return 28;
  }

  static double getBodyText(BuildContext context) {
    double width = getWidth(context);
    if (width < 600) return 12;
    if (width < 1100) return 13;
    return 14;
  }

  // Responsive padding
  static double getHorizontalPadding(BuildContext context) {
    double width = getWidth(context);
    if (width < 600) return 12;
    if (width < 1100) return 16;
    return 24;
  }

  static double getVerticalPadding(BuildContext context) {
    double width = getWidth(context);
    if (width < 600) return 12;
    if (width < 1100) return 16;
    return 24;
  }

  // Responsive grid columns
  static int getGridColumns(BuildContext context) {
    double width = getWidth(context);
    if (width < 600) return 1;
    if (width < 1100) return 2;
    return 3;
  }
}
