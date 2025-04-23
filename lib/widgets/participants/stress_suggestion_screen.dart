/// stress_suggestion_screen.dart
import 'package:flutter/material.dart';
import 'package:stressSense/theme/colors.dart';
import 'suggestion_helper.dart';

class StressSuggestionScreen extends StatelessWidget {
  final StressSuggestion suggestion;

  const StressSuggestionScreen({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stress Suggestions'),
        backgroundColor: AppColor.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              suggestion.level,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: AppColor.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              suggestion.message,
              style: const TextStyle(fontSize: 16, color: AppColor.black),
            ),
            const SizedBox(height: 20),
            ...suggestion.tips.map(
              (tip) => Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 4),
                child: Text(
                  "• $tip",
                  style: const TextStyle(fontSize: 15, color: AppColor.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
