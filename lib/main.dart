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
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: const LoginScreen(), // 👈 this is your first screen
    );
  }
}
