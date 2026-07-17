import 'package:flutter/material.dart';
import 'package:repair/app%20utils/app_colors.dart';

class AppStyles {
  static TextStyle bold24black = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.lightMainText
  );

  static TextStyle regular16DisabledText = TextStyle(
      fontSize: 16,
      color: AppColors.lightHintText
  );
  static TextStyle regular16MainTextColor = TextStyle(
      fontSize: 16,
      color: AppColors.lightMainText,
  );
  static TextStyle regular16AccentColor = TextStyle(
    fontSize: 16,
    color: AppColors.accentColor,
  );
}