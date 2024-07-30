import 'package:fertilizerapp/components/Colorpallet.dart';
import 'package:fertilizerapp/pages/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
 theme: ThemeData(
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  wordSpacing: 2),
              color: ColorPalette.Jungle_Green,
              iconTheme: IconThemeData(color: Colors.white)),
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(ColorPalette.Jungle_Green))),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedIconTheme:
                  IconThemeData(color: ColorPalette.appBar_color),
              unselectedIconTheme:
                  IconThemeData(color: ColorPalette.Jungle_Green))),
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}