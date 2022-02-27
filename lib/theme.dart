import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  late ThemeData themeData;
  ThemeChanger({required this.themeData});

  getTheme() => themeData;

  setTheme(theme) {
    themeData = theme;

    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade500,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
    iconTheme: const IconThemeData(color: Color(0xff03dac6), opacity: 0.8),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(const Color(0xff03dac6))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xff03dac6)),
      ),
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Color(0xff3b3c36)),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xfffbbf77)),
    iconTheme: const IconThemeData(
      color: Color(0xffffaba5),
    ),
    checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all<Color>(const Color(0xffd8b863))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(const Color(0xffd8b863)),
        // textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
        //   color: Colors.black,
        // )),
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Color(0xffffbc94),
        modalBackgroundColor: Color(0xfffbbf77)),
    cardColor: const Color(0xffffd899),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xfffbbf77),
    ),
  );
}
