import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

// Custom dark color scheme for glassy black/white/grey/blue theme
const ColorScheme _darkColors = ColorScheme.dark(
  primary: ColorConstants.blueAccentLight,  // Blue light accent
  primaryContainer: ColorConstants.blueAccentDark,
  secondary: ColorConstants.blueAccent,
  secondaryContainer: ColorConstants.blueAccentDark,
  surface: Color(0xFF0A1929), // Dark Blue
  error: ColorConstants.errorColor,
  onPrimary: ColorConstants.whiteColor,
  onSecondary: ColorConstants.whiteColor,
  onSurface: ColorConstants.whiteColor,
  onError: ColorConstants.blackColor,
  brightness: Brightness.dark,
  outline: Color(0xFF3D5A80), // Blue-grey outline
  shadow: ColorConstants.glassyBlack,
  inverseSurface: ColorConstants.blueAccent,
  onInverseSurface: ColorConstants.whiteColor,
  inversePrimary: ColorConstants.blueAccentLight,
);

const _appFontFamily = 'Roboto';

final ThemeData darkThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: _darkColors,
  primaryColor: ColorConstants.blueAccent,
  fontFamily: _appFontFamily,
  scaffoldBackgroundColor: const Color(0xFF0A1929), // Dark Blue
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF0A1929), // Dark Blue
    elevation: 0,
    iconTheme: IconThemeData(color: ColorConstants.whiteColor),
    titleTextStyle: TextStyle(
      color: ColorConstants.whiteColor,
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.0,
    ),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFF132F4C), // Lighter Dark Blue
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xFF1E3A5F), width: 0.5), // Blue-tinted border
    ),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return ColorConstants.midGrey;
          }
          return ColorConstants.blueAccentLight;
        },
      ),
      foregroundColor: WidgetStateProperty.all<Color>(ColorConstants.blackColor),
      elevation: WidgetStateProperty.resolveWith<double>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return 1;
          }
          return 3;
        },
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(ColorConstants.blueAccentLight),
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all<Color>(ColorConstants.whiteColor),
      side: WidgetStateProperty.all<BorderSide>(
        const BorderSide(color: ColorConstants.blueAccentLight, width: 2),
      ),
      padding: WidgetStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: ColorConstants.whiteColor,
    foregroundColor: ColorConstants.blackColor,
    elevation: 4,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color(0xFF2A4A6F)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Color(0xFF2A4A6F)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: ColorConstants.blueAccentLight, width: 2),
    ),
    filled: true,
    fillColor: Color(0xFF132F4C), // Lighter Dark Blue
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: ColorConstants.whiteColor,
      letterSpacing: 0.5,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: ColorConstants.whiteColor,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: ColorConstants.whiteColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorConstants.whiteColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorConstants.whiteColor,
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: ColorConstants.midGrey,
    thickness: 0.5,
    space: 1,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF0A1929), // Dark Blue
    selectedItemColor: ColorConstants.whiteColor,
    unselectedItemColor: ColorConstants.whiteColor70,
    showUnselectedLabels: true,
  ),
);