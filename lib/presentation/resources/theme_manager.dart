import 'package:flutter/material.dart';

import '/presentation/resources/color_manager.dart';
import '/presentation/resources/values_manager.dart';
import '/presentation/resources/styles_manager.dart';
import '/presentation/resources/font_manager.dart';

ThemeData getApplicationLightTheme() {
  return ThemeData(
    //!main colors
    primaryColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.white,
    brightness: Brightness.light,
    //!app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        shadowColor: ColorManager.lightPrimary,
        elevation: AppSize.s4,
        titleTextStyle:
            getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)),
    //!button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),
    //! elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                fontSize: FontSize.s17, color: ColorManager.white),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),
    //!text theme
    textTheme: TextTheme(
      headlineLarge:
          getBoldStyle(fontSize: FontSize.s25, color: ColorManager.darkGrey),
      headlineMedium:
          getBoldStyle(fontSize: FontSize.s20, color: ColorManager.darkGrey),
      headlineSmall:
          getMeduimStyle(fontSize: FontSize.s14, color: ColorManager.red),
      titleLarge:
          getBoldStyle(fontSize: FontSize.s18, color: ColorManager.darkGrey),
      titleMedium: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.darkGrey,
      ),
      titleSmall: getMeduimStyle(
        fontSize: FontSize.s14,
        color: ColorManager.darkGrey,
      ),
      bodyLarge:
          getRegularStyle(fontSize: FontSize.s14, color: ColorManager.darkGrey),
      bodyMedium:
          getSemiBoldStyle(fontSize: FontSize.s12, color: ColorManager.grey),
      bodySmall:
          getRegularStyle(fontSize: FontSize.s14, color: ColorManager.darkGrey),
      labelLarge:
          getBoldStyle(fontSize: FontSize.s16, color: ColorManager.white),
      labelMedium:
          getMeduimStyle(fontSize: FontSize.s30, color: ColorManager.white),
      labelSmall:
          getLightStyle(fontSize: FontSize.s13, color: ColorManager.white),
    ),

    //!Input decoration theme(text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.darkGrey,
      ),
      labelStyle: getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.darkGrey,
      ),
      errorStyle:
          getRegularStyle(fontSize: FontSize.s14, color: ColorManager.red),
      enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.white, width: AppSize.s0),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.primary, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.red, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.primary, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}

ThemeData getApplicationDarkTheme() {
  return ThemeData(
    //!main colors
    primaryColor: ColorManager.darkGrey,
    scaffoldBackgroundColor: ColorManager.darkGrey,
    brightness: Brightness.dark, // ripple effect color

    //!app bar theme
    appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.primary,
        shadowColor: ColorManager.lightPrimary,
        elevation: AppSize.s4,
        titleTextStyle:
            getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white)),
    //!button theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),
    //! elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(
                fontSize: FontSize.s17, color: ColorManager.white),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),
    //!text theme
    textTheme: TextTheme(
      headlineLarge:
          getBoldStyle(fontSize: FontSize.s25, color: ColorManager.white),
      headlineMedium:
          getBoldStyle(fontSize: FontSize.s20, color: ColorManager.white),
      headlineSmall:
          getMeduimStyle(fontSize: FontSize.s14, color: ColorManager.red),
      titleLarge:
          getBoldStyle(fontSize: FontSize.s18, color: ColorManager.white),
      titleMedium: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.white,
      ),
      titleSmall: getMeduimStyle(
        fontSize: FontSize.s14,
        color: ColorManager.white,
      ),
      bodyLarge:
          getRegularStyle(fontSize: FontSize.s14, color: ColorManager.white),
      bodyMedium:
          getSemiBoldStyle(fontSize: FontSize.s12, color: ColorManager.grey),
      bodySmall: getRegularStyle(
          fontSize: FontSize.s14, color: ColorManager.whiteGray),
      labelLarge:
          getBoldStyle(fontSize: FontSize.s16, color: ColorManager.white),
      labelMedium:
          getMeduimStyle(fontSize: FontSize.s30, color: ColorManager.white),
      labelSmall:
          getLightStyle(fontSize: FontSize.s13, color: ColorManager.white),
    ),

    //!Input decoration theme(text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.white,
      ),
      labelStyle: getRegularStyle(
        fontSize: FontSize.s14,
        color: ColorManager.white,
      ),
      errorStyle:
          getRegularStyle(fontSize: FontSize.s14, color: ColorManager.red),
      enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.white, width: AppSize.s0),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.primary, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.red, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: ColorManager.primary, width: AppSize.s1),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
  );
}
