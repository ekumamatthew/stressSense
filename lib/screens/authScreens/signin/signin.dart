import 'package:flutter/material.dart';
import 'package:my_fizi_app/screens/authScreens/resetPassword/resetPassword.dart';
import 'package:my_fizi_app/screens/dashboardScreens/layout/dashboardPage.dart';

import 'package:my_fizi_app/theme/colors.dart';
import 'package:my_fizi_app/widgets/buttonsWidget/buttons.dart';
import 'package:my_fizi_app/widgets/inputs/customInputs.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String phoneNumber = '';
  String password = '';

  void _handlePhoneNumberChanged(String newPhoneNumber) {
    setState(() {
      phoneNumber = newPhoneNumber;
    });
  }

  void _handlePasswordChanged(String newPassword) {
    setState(() {
      password = newPassword;
    });
  }

  void _handleSubmit() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Dashboard()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Welcome Back',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF0E47D8),
                      fontSize: 28,
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500,
                      // height: 0.04,
                      letterSpacing: -1.12,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Enter your details to access your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2E3034),
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                      letterSpacing: 0.03,
                    ),
                  ),
                  const SizedBox(height: 100),
                  Column(
                    children: <Widget>[
                      CustomInput(
                        initialValue: phoneNumber,
                        onChanged: _handlePhoneNumberChanged,
                        label: 'Entetr Your Phone Number',
                        tag: 'Phone Number',
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      CustomInput(
                        initialValue: password,
                        onChanged: _handlePasswordChanged,
                        label: 'Password',
                        tag: 'Password',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPassword()),
                              );
                            },
                            child: const Text(
                              "Reset Your Password",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColor.blue,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 100,
                      ),
                      Button1(
                          text: 'Login',
                          onPressed: _handleSubmit,
                          backgroundColor: AppColor.blue,
                          width: 357,
                          padding: const EdgeInsets.all(16),
                          textColor: AppColor.white,
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          letterSpacing: 0.03),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don’t have an account?',
                              style: TextStyle(
                                color: AppColor.gray,
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                                height: 0.10,
                                letterSpacing: 0.03,
                              ),
                            ),
                            TextSpan(
                              text: ' Sign Up',
                              style: TextStyle(
                                color: AppColor.blue,
                                fontSize: 16,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                height: 0.10,
                                letterSpacing: 0.03,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
