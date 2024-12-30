import 'package:flutter/material.dart';
import 'package:stressSense/theme/colors.dart';
import 'package:stressSense/widgets/buttonsWidget/buttons.dart';
import 'package:stressSense/widgets/inputs/otpInput.dart';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                    child: Text(
                      'Verify your email',
                      style: TextStyle(
                        color: AppColor.gray,
                        fontSize: 28,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.w500,
                        height: 0.04,
                        letterSpacing: -1.12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 356,
                    height: 20,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Please enter the OTP sent to ',
                            style: TextStyle(
                              color: Color(0xFF595D66),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w500,
                              height: 0.10,
                              letterSpacing: 0.03,
                            ),
                          ),
                          TextSpan(
                            text: '+234*****7890',
                            style: TextStyle(
                              color: Color(0xFF030B22),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w700,
                              height: 0.10,
                              letterSpacing: 0.03,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Adjust spacing as needed
                    children: <Widget>[
                      OtpInput(onChanged: (value) {}, initialValue: digit1),
                      OtpInput(onChanged: (value) {}, initialValue: digit2),
                      OtpInput(onChanged: (value) {}, initialValue: digit3),
                      OtpInput(onChanged: (value) {}, initialValue: digit4),
                      OtpInput(onChanged: (value) {}, initialValue: digit6),
                      OtpInput(onChanged: (value) {}, initialValue: digit6),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    '0:50',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF595D66),
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w500,
                      height: 0.10,
                      letterSpacing: 0.03,
                    ),
                  ),
                  Container(
                    width: 357,
                    height: 54,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 16,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: Stack(children: []),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Resend Code',
                          style: TextStyle(
                            color: AppColor.gray,
                            fontSize: 14,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            height: 0.11,
                            letterSpacing: 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
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
    );
  }
}
