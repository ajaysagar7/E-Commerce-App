import 'package:flutter/material.dart';

import 'app_fonts.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}

//*regular style
TextStyle getRegularStyle(
    {double fontSize = AppFontSize.s18, required Color color}) {
  return _getTextStyle(
      fontSize, AppFonts.fontFamily, AppFontWeightManager.regular, color);
}

//* light text style
TextStyle getLightStyle(
    {double fontSize = AppFontSize.s18, required Color color}) {
  return _getTextStyle(
      fontSize, AppFonts.fontFamily, AppFontWeightManager.light, color);
}

//* medium text style
TextStyle getMediumStyle(
    {double fontSize = AppFontSize.s18, required Color color}) {
  return _getTextStyle(
      fontSize, AppFonts.fontFamily, AppFontWeightManager.bold, color);
}

//* semi bold text style
TextStyle getSemiBoldStyle(
    {double fontSize = 16.0, required Color color}) {
  return _getTextStyle(
      fontSize, AppFonts.fontFamily, AppFontWeightManager.semiBold, color);
}

//* bold text style
TextStyle getBoldStyle(
    {double fontSize = AppFontSize.s18, required Color color}) {
  return _getTextStyle(
      fontSize, AppFonts.fontFamily, AppFontWeightManager.bold, color);
}
