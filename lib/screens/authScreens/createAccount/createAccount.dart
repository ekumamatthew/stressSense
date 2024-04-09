import 'package:flutter/material.dart';
import 'package:stressSense_lab/theme/colors.dart';
import 'package:stressSense_lab/theme/colors.dart';
import 'package:stressSense_lab/widgets/stepperWidget/stepper.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: StepperForm(),
    ));
  }
}
