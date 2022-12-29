import 'package:flutter/material.dart';

import 'app_colors.dart';

/// The styles called H1-H6 in the spec are headline1-headline6 in the API,
/// and body1,body2 are called bodyText1 and bodyText2.
/// https://api.flutter.dev/flutter/material/TextTheme-class.html
class AppTheme {
  static const fontFamily = 'NotoSansJP';

  /// The overall brightness of this color scheme.
  final Brightness brightness;

  /// The color displayed most frequently across your app’s screens and components.
  final Color primaryColor;
  final Color primaryVariantColor;

  /// An accent color that, when used sparingly, calls attention to parts
  /// of your app.
  final Color secondaryColor;
  final Color secondaryVariantColor;

  Color get accentColor => secondaryColor;

  Color get accentVariantColor => secondaryColor;

  /// A color that typically appears behind scrollable content.
  final Color backgroundColor;

  final Color primaryTextColor;
  final Color secondaryTextColor;

  final TextTheme textTheme;

  /// Create a ColorScheme instance.
  const AppTheme({
    required this.brightness,
    this.primaryColor = const Color(0xff5280FF),
    this.primaryVariantColor = const Color(0xff83A4FF),
    this.secondaryColor = const Color(0xffFF67AE),
    this.secondaryVariantColor = const Color(0xffFFA6CB),
    this.backgroundColor = const Color(0xffF4F6FA),
    this.primaryTextColor = const Color(0xff3A415C),
    this.secondaryTextColor = const Color(0xff7C85A9),
    this.textTheme = const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        fontSize: 32,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        color: AppColors.primaryTextLightColor,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: AppColors.primaryVariantTextLightColor,
        fontWeight: FontWeight.w400,
      ),
    ),
  });

  factory AppTheme.light() {
    return const AppTheme(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryLightColor,
      // primaryVariantColor: AppColors.primaryVariantLightColor,
      // secondaryColor: AppColors.secondaryLightColor,
      // secondaryVariantColor: AppColors.secondaryVariantLightColor,
      // backgroundColor: AppColors.backgroundLightColor,
      primaryTextColor: AppColors.primaryTextLightColor,
      // secondaryTextColor: AppColors.secondaryTextLightColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          color: AppColors.primaryTextLightColor,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: AppColors.primaryVariantTextLightColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  factory AppTheme.dark() {
    return const AppTheme(
      brightness: Brightness.light,
      // primaryColor: AppColors.primaryDarkColor,
      // primaryVariantColor: AppColors.primaryVariantDarkColor,
      // secondaryColor: AppColors.secondaryDarkColor,
      // secondaryVariantColor: AppColors.secondaryVariantDarkColor,
      // backgroundColor: AppColors.backgroundDarkColor,
      primaryTextColor: AppColors.primaryTextDarkColor,
      // secondaryTextColor: AppColors.secondaryTextDarkColor,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w400,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          color: AppColors.primaryTextDarkColor,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: AppColors.primaryVariantTextDarkColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  ThemeData themeData(){
    return ThemeData(
      fontFamily: fontFamily,
      brightness: brightness,
      backgroundColor: backgroundColor,
      // cursorColor: AppColors.blueLightColor,
      scaffoldBackgroundColor: backgroundColor,
      // accentColor: accentColor,
      // colorScheme: ColorScheme(
      //   primary: primaryColor,
      //   primaryVariant: primaryVariantColor,
      //   secondary: secondaryColor,
      //   secondaryVariant: secondaryVariantColor,
      //   surface: backgroundColor,
      //   background: backgroundColor,
      //   error: Colors.red,
      //   onPrimary: Colors.white,
      //   onSecondary: Colors.white,
      //   onSurface: Colors.white,
      //   onBackground: Colors.white,
      //   onError: Colors.red,
      //   brightness: brightness,
      // ),
      textTheme: textTheme,
      // iconTheme: IconThemeData(color: secondaryVariantColor),
      // shadowColor: ,
      // dividerColor: ,
      // unselectedWidgetColor: ,
    );
  }
}