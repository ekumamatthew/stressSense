import 'package:flutter/material.dart';
import 'package:my_fizi_app/screens/authScreens/createAccount/component/createAccountForm.dart';
import 'package:my_fizi_app/theme/colors.dart';
import 'package:my_fizi_app/widgets/buttonsWidget/buttons.dart';

class StepperForm extends StatefulWidget {
//   @override
//   _StepperFormState createState() => _StepperFormState();
// }

// class _StepperFormState extends State<StepperForm> {
//   int _currentStep = 0;
// // Instance of the form data model

  final List<Step> steps;
  final int currentStep;

  const StepperForm({
    Key? key,
    required this.steps,
    this.currentStep = 0,
  }) : super(key: key);

  @override
  _StepperFormState createState() => _StepperFormState();
}

class Step {
  final String title;
  final Widget content;

  Step({required this.title, required this.content});
}

List<Step> mySteps = [
  Step(
    title: 'Step 1',
    content: Column(
      children: [AccountForm()],
    ),
  ),
  Step(
    title: 'Step 2',
    content: const Column(
      children: [
        Text('This is Step 2'),
        // Add other widgets for Step 2 content
      ],
    ),
  ),
  Step(
    title: 'Step 3',
    content: const Column(
      children: [
        Text('You have reached Step 3'),
        // Add other widgets for Step 3 content
      ],
    ),
  ),
];

class _StepperFormState extends State<StepperForm> {
  late int _currentStep;

  @override
  void initState() {
    super.initState();
    _currentStep = widget.currentStep;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(children: [
              //-----------------Stepper Indicator Starts Here-----------------------//
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 170,
                height: 14,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF0E47D8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(75),
                        ),
                      ),
                      child: const Stack(children: []),
                    ),
                    Container(
                      height: 1, // Thickness of the line
                      color: AppColor.blue, // Color of the line
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20), // Horizontal margin
                    ),
                    Opacity(
                      opacity: 0.20,
                      child: Container(
                        width: 14,
                        height: 14,
                        padding: const EdgeInsets.only(
                          top: 2,
                          left: 1.75,
                          right: 2.25,
                          bottom: 2,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF0E47D8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(75),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Stack(children: []),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: AppColor.blue,
                      height: 20,
                      thickness: 4, // The thickness of the line.
                      indent:
                          20, // Empty space to the leading edge of the divider.
                      endIndent:
                          20, // Empty space to the trailing edge of the divider.
                    ),
                    Opacity(
                      opacity: 0.20,
                      child: Container(
                        width: 14,
                        height: 14,
                        padding: const EdgeInsets.only(
                          top: 2,
                          left: 1.75,
                          right: 2.25,
                          bottom: 2,
                        ),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF0E47D8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(75),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Stack(children: [
                                        Text(
                                          "-",
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
//--------------------------------Stepper indicator ends here----------------------//
              const SizedBox(
                height: 50,
              ),
              mySteps[_currentStep].content,
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Button1(
                    text: "Continue →",
                    onPressed: () {},
                    backgroundColor: AppColor.blue,
                    width: 375.0,
                    padding: const EdgeInsets.all(20),
                    textColor: AppColor.white,
                    fontFamily: 'Raleway',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                    letterSpacing: 0.032,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Already have an account?',
                          style: TextStyle(
                            color: Color(0xFF2E3034),
                            fontSize: 16,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            height: 0.10,
                            letterSpacing: 0.03,
                          ),
                        ),
                        TextSpan(
                          text: ' Log in',
                          style: TextStyle(
                            color: Color(0xFF0E47D8),
                            fontSize: 16,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            height: 0.10,
                            letterSpacing: 0.03,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ]),
          ),
        ));
  }
}
