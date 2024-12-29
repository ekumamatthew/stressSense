import 'package:flutter/material.dart';
import 'package:neuroTrack/theme/colors.dart';
import 'package:neuroTrack/widgets/buttonsWidget/buttons.dart';

void slideupBottomSheet(BuildContext context,
    {required VoidCallback onLoginPressed,
    required VoidCallback onSignupPressed}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor.white,
    builder: (BuildContext bc) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Button1(
              text: 'Create account',
              onPressed: () {
                onSignupPressed();
              },
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
            Button1(
              text: 'Login',
              onPressed: () {
                onLoginPressed();
              },
              backgroundColor: AppColor.white,
              width: 375.0,
              padding: const EdgeInsets.all(20),
              textColor: AppColor.black,
              fontFamily: 'Raleway',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              height: 1.4,
              letterSpacing: 0.032,
              borderColor: AppColor.blue,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    },
  );
}
