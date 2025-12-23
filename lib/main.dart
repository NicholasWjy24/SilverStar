import 'package:flutter/material.dart';
import 'package:silverstar_mobile/view/Login_Screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyB0qos6u-vFpojvd-F_ZHPmVHfgt8ACkig',
        appId: '1:980104717760:android:262fc15685d85ba2309425',
        messagingSenderId: '980104717760',
        projectId: 'silverstar-mobile-app',
      )
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: 'SilverStar Mobile',
      home: const LoginScreen(),
    );
  }
}
