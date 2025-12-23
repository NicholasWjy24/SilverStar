import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:silverstar_mobile/background.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final authService = AuthService();

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SilkyMetallicBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text('Register')
            ]),
          ),
        ),
      ),
    );
  }
}
