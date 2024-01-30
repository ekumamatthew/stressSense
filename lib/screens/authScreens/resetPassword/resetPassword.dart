import 'package:flutter/material.dart';
import 'package:my_fizi_app/screens/authScreens/verifyEmail/verifyEmail.dart';
import 'package:my_fizi_app/theme/colors.dart';
import 'package:my_fizi_app/widgets/buttonsWidget/buttons.dart';
import 'package:my_fizi_app/widgets/inputs/customInputs.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  String phoneNumber = '';
  void _handleOnChange(newPhoneNumber) {
    setState(() {
      phoneNumber = newPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: <Widget>[
                      const Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text('Reset Your Password',
                              style: TextStyle(
                                color: AppColor.gray,
                                fontSize: 28,
                                fontFamily: 'Ubuntu',
                                fontWeight: FontWeight.w500,
                                height: 0.04,
                                letterSpacing: -1.12,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Please enter your phone number to reset your password',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                              color: Color(0xFF595D66),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              height: 0.10,
                              letterSpacing: 0.03,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomInput(
                          initialValue: phoneNumber,
                          onChanged: _handleOnChange,
                          label: "Phone Number",
                          tag: "Phone Number"),
                    ],
                  ),
                  Column(
                    children: [
                      Button1(
                          text: 'Next →',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const VerifyEmail()),
                            );
                          },
                          backgroundColor: AppColor.blue,
                          width: 357,
                          padding: const EdgeInsets.all(16),
                          textColor: AppColor.black,
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 0.10,
                          letterSpacing: 0.03),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
