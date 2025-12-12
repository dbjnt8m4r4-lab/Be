import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

// Custom light color scheme for glassy black/white/grey/blue theme
const ColorScheme _monoScheme = ColorScheme(
  brightness: Brightness.light,
  primary: ColorConstants.blueAccent,
  onPrimary: ColorConstants.whiteColor,
  secondary: ColorConstants.blueAccentLight,
  onSecondary: ColorConstants.whiteColor,
  error: ColorConstants.errorColor,
  onError: ColorConstants.whiteColor,
  surface: ColorConstants.glassyWhite,
  onSurface: ColorConstants.darkGrey,
  tertiary: ColorConstants.blueAccentDark,
  onTertiary: ColorConstants.whiteColor,
  surfaceContainerHighest: ColorConstants.glassyWhite,
  onSurfaceVariant: ColorConstants.darkGrey,
  outline: ColorConstants.midGrey,
  shadow: ColorConstants.glassyBlack,
  inverseSurface: ColorConstants.blueAccent,
  onInverseSurface: ColorConstants.whiteColor,
  inversePrimary: ColorConstants.blueAccentLight,
);

final ThemeData lightThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: _monoScheme,
  primaryColor: ColorConstants.blueAccent,
  fontFamily: defaultTargetPlatform == TargetPlatform.iOS ? '.SF Pro Text' : 'Roboto',
  scaffoldBackgroundColor: ColorConstants.glassyWhite,
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorConstants.glassyWhite,
    elevation: 0,
    iconTheme: IconThemeData(color: ColorConstants.darkGrey),
    titleTextStyle: TextStyle(
      color: ColorConstants.darkGrey,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  ),
  cardTheme: CardThemeData(
    color: ColorConstants.glassyWhite,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18),
      side: const BorderSide(color: ColorConstants.blueAccentLight),
    ),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return ColorConstants.lightGrey;
          }
          return ColorConstants.blueAccent;
        },
      ),
      foregroundColor: WidgetStateProperty.all<Color>(ColorConstants.whiteColor),
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
      foregroundColor: WidgetStateProperty.all<Color>(ColorConstants.blueAccent),
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
      foregroundColor: WidgetStateProperty.all<Color>(ColorConstants.blueAccent),
      side: WidgetStateProperty.all<BorderSide>(
        const BorderSide(color: ColorConstants.blueAccent, width: 2),
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
    backgroundColor: ColorConstants.blueAccent,
    foregroundColor: ColorConstants.whiteColor,
    elevation: 4,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: ColorConstants.blueAccentLight),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: ColorConstants.blueAccentLight),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: ColorConstants.blueAccent, width: 2),
    ),
    filled: true,
    fillColor: ColorConstants.glassyWhite,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: defaultTargetPlatform == TargetPlatform.iOS ? 26 : 28,
      fontWeight: FontWeight.w700,
      color: ColorConstants.blackColor,
      letterSpacing: 0.2,
    ),
    headlineMedium: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: ColorConstants.blackColor,
    ),
    titleLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: ColorConstants.blackColor,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ColorConstants.blackColor,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorConstants.blackColor,
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: ColorConstants.midGrey,
    thickness: 0.5,
    space: 1,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: ColorConstants.glassyWhite,
    selectedItemColor: ColorConstants.blueAccent,
    unselectedItemColor: ColorConstants.midGrey,
    showUnselectedLabels: true,
    elevation: 0,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: ColorConstants.blackColor,
    contentTextStyle: TextStyle(color: ColorConstants.whiteColor),
    behavior: SnackBarBehavior.floating,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: ColorConstants.blackColor,
  ),
);