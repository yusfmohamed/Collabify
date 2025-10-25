import 'package:flutter/material.dart';

class AppColors {
  // Primary colors from the design
  static const primaryPurple = Color(0xFF6B2FD9);
  static const deepPurple = Color(0xFF4A148C);
  static const darkPurple = Color(0xFF311B92);
  
  // Gradient colors
  static const gradientTop = Color(0xFF4A148C);      // Deep purple top
  static const gradientMiddle = Color(0xFF5E35B1);   // Medium purple
  static const gradientBottom = Color(0xFF00BCD4);   // Cyan bottom
  
  static const cyan = Color(0xFF00BCD4);
  static const lightCyan = Color(0xFF00E5FF);
  
  // UI elements
  static const cardBackground = Color(0xFFF5F5F5);
  static const textDark = Color(0xFF333333);
  static const textLight = Color(0xFF666666);
  static const white = Colors.white;
  static const inputBorder = Color(0xFFE0E0E0);

  static var borderColor;

  static var iconColor;

  static var hintText;

  static var primaryColor;
}

class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryPurple,
    letterSpacing: 0.5,
  );

  static const button = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    letterSpacing: 1.0,
  );

  static const link = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.cyan,
  );

  static const linkPurple = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryPurple,
  );

  static const input = TextStyle(
    fontSize: 18,
    color: AppColors.textDark,
    fontWeight: FontWeight.w400,
  );

  static const hint = TextStyle(
    fontSize: 18,
    color: AppColors.textLight,
    fontWeight: FontWeight.w400,
  );
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.primaryPurple,
      scaffoldBackgroundColor: Colors.transparent,  // Updated: Ensures global transparent background
      fontFamily: 'Roboto',
      useMaterial3: true,
    );
  }
}