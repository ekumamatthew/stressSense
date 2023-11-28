import 'package:flutter/material.dart';
import 'package:my_fizi_app/theme/colors.dart';
import 'package:my_fizi_app/theme/colors.dart';

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
      appBar: AppBar(),
      body: Theme(
        data: ThemeData(
          // Define the default brightness and colors.
          primaryColor: AppColor.blue,
          secondaryHeaderColor: AppColor.blue,

          primarySwatch: Colors.blue,
          // Define the default font family.
          fontFamily: 'ubuntu',
          colorScheme: const ColorScheme.light(
              primary: AppColor.blue, secondary: AppColor.blue),

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'ubuntu'),
          ),
        ),
        child: Stepper(
          type: StepperType.horizontal,
          currentStep: _currentStep,
          onStepContinue: () {
            setState(() {
              if (_currentStep < 2) {
                _currentStep++;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep--;
              }
            });
          },
          onStepTapped: (step) {
            setState(() {
              _currentStep = step;
            });
          },
          steps: [
            Step(
              title: const Text('Step 1'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Content for Step 1'),
              ),
            ),
            Step(
              title: const Text('Step 2'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Content for Step 2'),
              ),
            ),
            Step(
              title: const Text('Step 3'),
              content: Container(
                alignment: Alignment.centerLeft,
                child: const Text('Content for Step 3'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//   List<Step> _getSteps() {
//     return [
//       Step(
//         title: Text(""),
//         content: Column(
//           children: <Widget>[
//             const Text(
//               "Create Account",
//               style: TextStyle(
//                 fontSize: 28.0,
//                 fontWeight: FontWeight.w500,
//                 color: AppColor.blue,
//                 fontFamily: "ubuntu",
//                 height: 12,
//                 letterSpacing: -1.12,
//               ),
//             ),
//             TextFormField(
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextFormField(
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//           ],
//         ),
//         isActive: _currentStep >= 0,
//         state: _currentStep >= 0 ? StepState.complete : StepState.disabled,
//       ),
//       Step(
//         title: const Text(''),
//         content: Text('Information for step 2'),
//         isActive: _currentStep >= 1,
//         state: _currentStep >= 1 ? StepState.complete : StepState.disabled,
//       ),
//       Step(
//         title: const Text(''),
//         content: Text('Information for step 3'),
//         isActive: _currentStep >= 2,
//         state: _currentStep >= 2 ? StepState.complete : StepState.disabled,
//       ),
//       // Add more steps if needed
//     ];
//   }
// }
