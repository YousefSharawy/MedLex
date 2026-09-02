import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false,
    primaryColor: ColorManager.primaryTeal,
    scaffoldBackgroundColor: ColorManager.background,
    fontFamily: FontConstants.fontFamily,
    textTheme: _textTheme(),
    dialogTheme: const DialogThemeData(backgroundColor: ColorManager.white),

    colorScheme: const ColorScheme.light(
      primary: ColorManager.primaryTeal,
      surface: ColorManager.white,
      surfaceTint: Colors.transparent,
      secondary: ColorManager.secondary,
      error: ColorManager.error,
      onPrimary: ColorManager.white,
      onSurface: ColorManager.primaryText,
      onSecondary: ColorManager.white,
    ),

    elevatedButtonTheme: _elevatedButtonTheme(),
    outlinedButtonTheme: _outlineButtonTheme(),
    appBarTheme: _appBarTheme(),
    inputDecorationTheme: _inputDecorationTheme(),
    dividerTheme: DividerThemeData(
      color: ColorManager.divider,
      thickness: 1.3.h,
    ),
    switchTheme: const SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(ColorManager.primaryTeal),
      trackOutlineColor: WidgetStatePropertyAll(ColorManager.divider),
      trackColor: WidgetStatePropertyAll(ColorManager.white),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.s2),
      ),
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(width: AppSize.s1, color: ColorManager.primaryTeal),
      ),
    ),
  );
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    hintStyle: getLightStyle(
      color: ColorManager.secondaryText,
      fontSize: FontSize.s14,
    ),
    labelStyle: getRegularStyle(
      color: ColorManager.secondaryText,
      fontSize: FontSize.s12,
    ),
    contentPadding: EdgeInsets.fromLTRB(
      AppWidth.s16,
      AppHeight.s9,
      AppWidth.s16,
      AppHeight.s9,
    ),
    filled: true,
    fillColor: ColorManager.lightGrey,
    constraints: BoxConstraints(
      maxHeight: AppHeight.s44,
      minHeight: AppHeight.s44,
    ),
    focusedBorder: getOutlineInputBorder(color: ColorManager.primaryTeal, width: 1),
    disabledBorder: getOutlineInputBorder(),
    enabledBorder: getOutlineInputBorder(),
    errorBorder: getOutlineInputBorder(color: ColorManager.error, width: 1),
    focusedErrorBorder: getOutlineInputBorder(color: ColorManager.error, width: 1),
  );
}

getOutlineInputBorder({Color? color, double? width}) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      width: width ?? 0,
      color: color ?? ColorManager.divider,
    ),
    borderRadius: BorderRadius.circular(AppRadius.s30),
  );
}

BoxShadow getprimaryTealBoxShadow() {
  return BoxShadow(
    color: ColorManager.black.withValues(alpha: 0.07),
    blurRadius: AppRadius.s10,
    spreadRadius: AppRadius.s1,
    offset: const Offset(0, 0),
  );
}

TextTheme _textTheme() {
  return TextTheme(
    headlineLarge: null,
    headlineMedium: getBoldStyle(
      fontSize: FontSize.s18,
      color: ColorManager.primaryText,
    ),
    headlineSmall: getRegularStyle(
      fontSize: FontSize.s18,
      color: ColorManager.primaryText,
    ),
    titleLarge: getBoldStyle(
      fontSize: FontSize.s16,
      color: ColorManager.primaryText,
    ),
    titleMedium: getBoldStyle(
      fontSize: FontSize.s14,
      color: ColorManager.primaryText,
    ),
    titleSmall: getRegularStyle(
      fontSize: FontSize.s16,
      color: ColorManager.secondaryText,
    ),
    labelLarge: getBoldStyle(
      fontSize: FontSize.s12,
      color: ColorManager.primaryText,
    ),
    labelMedium: getRegularStyle(
      fontSize: FontSize.s14,
      color: ColorManager.secondaryText,
    ),
    labelSmall: getRegularStyle(
      fontSize: FontSize.s12,
      color: ColorManager.secondaryText,
    ),
    bodyLarge: getBoldStyle(
      fontSize: FontSize.s10,
      color: ColorManager.primaryText,
    ),
    bodyMedium: null,
    bodySmall: getRegularStyle(
      fontSize: FontSize.s10,
      color: ColorManager.secondaryText,
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s14,
      ),
      backgroundColor: ColorManager.primaryTeal,
      foregroundColor: ColorManager.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.s30),
      ),
    ),
  );
}

_outlineButtonTheme() {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: getRegularStyle(
        color: ColorManager.primaryTeal,
        fontSize: FontSize.s14,
      ),
      foregroundColor: ColorManager.primaryTeal,
      backgroundColor: ColorManager.white,
      elevation: 0,
      side: const BorderSide(width: 1, color: ColorManager.divider),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.s30),
      ),
    ),
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(color: ColorManager.primaryText),
    backgroundColor: Colors.transparent,
    centerTitle: true,
    titleTextStyle: getBoldStyle(
      color: ColorManager.primaryText,
      fontSize: FontSize.s16,
    ),
    elevation: 0.0,
  );
}