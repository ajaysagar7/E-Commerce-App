import 'package:flutter/material.dart';
 
class AppColors {
  //* light theme colors
  static Color primary = HexColor.fromHex("#04181c");
  static Color appBarColor = HexColor.fromHex("#8a0a39");
  static Color disabledColor = Colors.grey.shade200;
 
//* dark theme colors
  static Color darkPrimary = HexColor.fromHex("#04181c");
  static Color darkappBarColor = HexColor.fromHex("#8a0a39");
 
  //* common colors
  static Color whiteColor = Colors.white;
  static Color grey = Colors.grey;
  static Color error = Colors.red;
  static Color grey1 = Colors.grey.shade100;
}
 
extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
 
 
 
 
 

