import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'theme_manager.dart';
import '/presentation/resources/strings_manager.dart';
import '/presentation/resources/theme_manager.dart';
import '../presentation/resources/routes_manager.dart';

class MyApp extends StatefulWidget {
  //const MyApp({super.key});
  const MyApp._internal();
  static const _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: getApplicationLightTheme(),
      darkTheme: getApplicationDarkTheme(),
      themeMode: ThemeManager().themeMode,
      title: AppStrings.toDo,
      locale: Get.deviceLocale,
      fallbackLocale: Get.fallbackLocale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.home,
    );
  }
}
