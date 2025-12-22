import 'package:flutter/material.dart';
import 'package:silverstar_mobile/view/Login_Screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      title: 'SilverStar Mobile',
      home: const LoginScreen(), // 👈 this is your first screen
    );
  }
}
