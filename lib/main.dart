import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fertilizerapp/components/Colorpallet.dart';
import 'package:fertilizerapp/firebase_options.dart';
import 'package:fertilizerapp/login/login.dart';
import 'package:fertilizerapp/navbar/navbar.dart';
import 'package:fertilizerapp/navbar/app_navigation.dart';
import 'package:fertilizerapp/pages/billing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //widget binding
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp.router(
      
     
    
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
      //  home: LoginPage(),
      routerConfig: AppNavigation.router,
    );
  }
}