import 'package:cryptotracker/helper/colors.dart';
import 'package:cryptotracker/local_storage/local_storage.dart';
import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.deepPurple, scaffoldBackgroundColor: white);
  ThemeData darkTheme = ThemeData.dark();
  late ThemeData themeData;

  ThemeNotifier(String theme) {
    if (theme == "light") {
      themeData = lightTheme;
    } else {
      themeData = darkTheme;
    }
  }

  void toggleTheme() async {
    if (themeData == lightTheme) {
      themeData = darkTheme;
      await LocalStorage.saveTheme("dark");
    } else {
      themeData = lightTheme;

      await LocalStorage.saveTheme("light");
    }
    notifyListeners();
  }
}
