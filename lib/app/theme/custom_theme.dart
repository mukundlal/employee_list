import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  static final customTheme = ThemeData.light().copyWith(
      textTheme: GoogleFonts.robotoTextTheme(),
      colorScheme: const ColorScheme.light(
          primary: AppColors.PRIMARY_COLOR,
          secondary: AppColors.PRIMARY_LITE_COLOR,
          background: AppColors.BACKGROUND_COLOR));
}

class AppColors {
  static const PRIMARY_COLOR = Color(0xFF1DA1F2);
  static const PRIMARY_LITE_COLOR = Color(0xFFEDF8FF);
  static const BACKGROUND_COLOR = Color(0xFFF2F2F2);
}

class AppConstants {
  static const double radius4 = 4.0;
  static const double radius6 = 6.0;
  static const double radius8 = 8.0;
  static const double spaceSmall = 4.0;
  static const double spaceMedium = 6.0;
  static const double spaceLarge = 8.0;
}
