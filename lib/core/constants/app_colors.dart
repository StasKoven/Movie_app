import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFE50914);
  static const Color primaryDark = Color(0xFFB20710);
  static const Color primaryLight = Color(0xFFFF1F28);
  
  // Background Colors
  static const Color background = Color(0xFF141414);
  static const Color backgroundLight = Color(0xFF1F1F1F);
  static const Color cardBackground = Color(0xFF2A2A2A);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB3B3B3);
  static const Color textTertiary = Color(0xFF808080);
  
  // Accent Colors
  static const Color accent = Color(0xFFFFC107);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [backgroundLight, cardBackground],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
