
/*
The splash screen is the splash banner that has the app logo rotate before the onboarding screen.
In the splash screen there is a timer on line 44 that controls the display period before it routes to onboarding

from line 31-45 controls the animation effect and is refrenced in line
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stressSense/screens/onBoardScreen/onBoardScreen1.dart';
import 'package:stressSense/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _rotationAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
    _scaleAnimation =
        Tween<double>(begin: 1, end: 0).animate(_animationController);

    _animationController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 2 * 3.14159, // 360 degrees
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            );
          },
          child: Image.asset(
            'assets/images/logoImages/aiImage.png',
            width: 236.527,
            height: 212.736,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
