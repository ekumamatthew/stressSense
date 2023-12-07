import 'package:flutter/material.dart';
import 'package:my_fizi_app/widgets/dashboardWidgets/accountFrame.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: AccountWidget()),
    );
  }
}
