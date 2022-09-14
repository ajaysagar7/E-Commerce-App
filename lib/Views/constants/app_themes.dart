import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_styles.dart';
import 'app_values.dart';

//* main colors of the app
//* primaryColor:
//* card view theme
//* App bar theme
//* Button theme
//* Text theme
//* input decoration theme (text form field)

ThemeData getApplicationTheme() {
  return ThemeData(
      //*main colors of app

      primaryColor: AppColors.primary,
      primaryColorLight: AppColors.primary,
      disabledColor: AppColors.disabledColor,

      //* Card Theme
      cardTheme: CardTheme(
        color: AppColors.whiteColor,
        shadowColor: AppColors.grey,
        elevation: AppSize.s4,
      ),

      //* Appbar Theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: AppColors.primary,
          elevation: AppSize.s4,
          shadowColor: AppColors.primary,
          titleTextStyle: getRegularStyle(
              color: AppColors.whiteColor, fontSize: AppFontSize.s16)),

      //* Button Theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: AppColors.disabledColor,
        buttonColor: AppColors.primary,
        splashColor: AppColors.primary,
      ),

      //* Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(
                color: AppColors.whiteColor,
              ),
              primary: AppColors.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      //* Text Theme Data
      textTheme: TextTheme(
        headline1:
            getSemiBoldStyle(color: AppColors.grey, fontSize: AppFontSize.s16),
        subtitle1: getMediumStyle(
            color: AppColors.disabledColor, fontSize: AppFontSize.s14),
        caption: getRegularStyle(color: AppColors.grey1),
        bodyText1: getRegularStyle(color: AppColors.grey1),
      ),

      //* Input-Decoration theme
      inputDecorationTheme: InputDecorationTheme(
        
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        hintStyle: getLightStyle(color: Colors.black),
        labelStyle: getRegularStyle(color: Colors.black),
        errorStyle: getRegularStyle(color: AppColors.error),
        helperStyle: getRegularStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: AppSize.s1),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.error, width: AppSize.s1_5),
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
      ));
}
