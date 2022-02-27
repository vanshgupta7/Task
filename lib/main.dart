// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/theme.dart';
import 'normaltasks.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of  your application.
  // final bool light = false;
  // final ThemeData _darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //   colorScheme: ColorScheme.dark(),
  // );
  // final ThemeData _lightTheme = ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: Colors.black12,
  //   colorScheme: ColorScheme.light(),
  // );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (context) => ThemeChanger(themeData: ThemeData.dark()),
      child: MaterialAppWithTheme(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      home: NormalTasks(),
      // theme: light ? _darkTheme : _lightTheme,
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
    );
  }
}
