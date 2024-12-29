import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neuroTrack/screens/dashboardScreens/layout/dashboardPage.dart';
import 'package:neuroTrack/screens/onBoardScreen/onBoardScreen1.dart';
import 'package:neuroTrack/screens/splashScreen/splashScreen.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeuroTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/onboarding': (context) => const OnboardingScreen(),
        '/dashboard': (context) => const Dashboard(),
        // Add other routes as needed
      },
    );
  }
}
