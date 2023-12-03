import 'package:flutter/material.dart';
import 'package:my_fizi_app/widgets/inputs/otpInput.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  String digit1 = '';
  String digit2 = '';
  String digit3 = '';
  String digit4 = '';
  String digit5 = '';
  String digit6 = '';

  void _handleChangeDigit1(newDigit1) {
    setState(() {
      digit1 = newDigit1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Adjust spacing as needed
                children: <Widget>[
                  OtpInput(onChanged: (value) {}, initialValue: digit1),
                  OtpInput(onChanged: (value) {}, initialValue: digit2),
                  OtpInput(onChanged: (value) {}, initialValue: digit3),
                  OtpInput(onChanged: (value) {}, initialValue: digit4),
                  OtpInput(onChanged: (value) {}, initialValue: digit6),
                  OtpInput(onChanged: (value) {}, initialValue: digit6),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
