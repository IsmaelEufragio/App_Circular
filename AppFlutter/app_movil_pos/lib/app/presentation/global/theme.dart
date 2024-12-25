import 'package:app_movil_pos/app/presentation/global/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme(bool dartkMode) {
  if (dartkMode) {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.dark,
      ),
      textTheme: GoogleFonts.nunitoSansTextTheme(
        ThemeData.dark().textTheme.copyWith(
              titleSmall: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              titleLarge: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              titleMedium: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              bodySmall: const TextStyle(
                color: Colors.white,
              ),
            ),
      ),
      scaffoldBackgroundColor: AppColors.darkLight,
      canvasColor: AppColors.dark,
      switchTheme: SwitchThemeData(
        trackColor: WidgetStateProperty.all(
          Colors.lightBlue.withOpacity(0.5),
        ),
        thumbColor: WidgetStateProperty.all(
          Colors.blue,
        ),
      ),
    );
  }

  final lightTheme = ThemeData.light();

  return lightTheme.copyWith(
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.dark),
    ),
    textTheme: GoogleFonts.nunitoSansTextTheme(
      lightTheme.textTheme.copyWith(
        titleSmall: const TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: const TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: const TextStyle(
          color: AppColors.dark,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: const TextStyle(
          color: AppColors.dark,
        ),
      ),
    ),
  );
}
