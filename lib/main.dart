/*  Main.dart is the app exit point where all other screens and components connects to

core screens refrenced here includes
splash screen on line 27

other are routed
onboarding screen line 35
dashboard screen line 36
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stressSense/screens/dashboardScreens/layout/dashboardPage.dart';
import 'package:stressSense/screens/onBoardScreen/onBoardScreen1.dart';
import 'package:stressSense/screens/splashScreen/splashScreen.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stress Sense',
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
