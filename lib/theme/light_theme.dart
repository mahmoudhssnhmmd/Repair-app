import 'package:flutter/material.dart';
import 'package:repair/app%20utils/app_colors.dart';
import 'package:repair/app%20utils/app_styles.dart';

const double borderRadius = 16.0;
const double borderWidth = 2.5;
const double padding = 16;
final InputBorder textFieldEnabledBorders = OutlineInputBorder(
  borderSide: BorderSide(width: borderWidth, color: AppColors.mainColor),
  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
);
final InputBorder textFieldFocusedBorders = textFieldEnabledBorders.copyWith(
  borderSide: BorderSide(width: borderWidth, color: AppColors.accentColor),
);
final InputBorder textFieldErrorBorders = textFieldEnabledBorders.copyWith(
  borderSide: BorderSide(color: Colors.red),
);

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.backGround,
  inputDecorationTheme: InputDecorationThemeData(
    border: textFieldEnabledBorders,
    enabledBorder: textFieldEnabledBorders,
    focusedBorder: textFieldFocusedBorders,
    errorBorder: textFieldErrorBorders,
    labelStyle: AppStyles.regular16DisabledText,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll(EdgeInsets.zero),
      visualDensity: VisualDensity.compact,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      padding: WidgetStatePropertyAll(EdgeInsets.all(padding)),
      backgroundColor: WidgetStatePropertyAll(AppColors.mainColor),
      overlayColor: WidgetStatePropertyAll(AppColors.accentColor),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
    ),
  ),
);
