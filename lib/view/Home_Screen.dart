import 'package:flutter/material.dart';
import 'package:silverstar_mobile/background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SilkyMetallicBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Column(
                children: [
                  Text('data'),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
