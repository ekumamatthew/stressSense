import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_fizi_app/screens/onBoardScreen1/onBoardScreen1.dart';
import 'package:my_fizi_app/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColor.blue,
      body: Center(
        // Your splash screen content here
        child: Text('my_Fizi_App',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: AppColor.white)),
      ),
    );
  }
}
