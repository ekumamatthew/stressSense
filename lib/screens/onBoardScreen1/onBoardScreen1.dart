import 'package:flutter/material.dart';
import 'package:my_fizi_app/theme/colors.dart';
import 'package:my_fizi_app/widgets/buttonsWidget/buttons.dart';
import 'package:my_fizi_app/widgets/slideWidget/slideupModal.dart';
import "package:my_fizi_app/screens/authScreens/createAccount/createAccount.dart";

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blue,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logoImages/fizi_logo.png',
                      width: 236.527,
                      height: 212.736,
                    ),
                    const Text(
                      'Simplify your',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.white,
                        fontFamily: 'Ubuntu',
                        fontSize: 48,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        letterSpacing: -2.4,
                      ),
                    ),
                    const Text(
                      'money matters',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColor.white,
                        fontFamily: 'Ubuntu',
                        fontSize: 48,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        letterSpacing: -2.4,
                      ),
                    ),
                    // Add more widgets for other onboarding content
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Button1(
                    text: 'Get Started',
                    onPressed: () {
                      slideupBottomSheet(
                        context,
                        onLoginPressed: () {
                          Navigator.pop(context); // Example action
                        },
                        onSignupPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAccount()),
                          );
                        },
                      );
                    },
                    backgroundColor: AppColor.white,
                    width: 375.0,
                    padding: const EdgeInsets.all(20),
                    textColor: AppColor.blue,
                    fontFamily: 'Raleway',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    letterSpacing: 0.032,
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
