import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeManager {
  final GetStorage box = GetStorage();
  final key = 'isDarkMode';

  // !Save Mode
  void saveThemeToBox(bool isDarkMode) {
    box.write(key, isDarkMode);
  }

  bool loadThemeFromBox() {
    return box.read<bool>(key) ?? false;
  }

  // !Get Saved Mode
  ThemeMode get themeMode =>
      loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  // !Change Mode
  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    saveThemeToBox(!loadThemeFromBox());
  }
}
