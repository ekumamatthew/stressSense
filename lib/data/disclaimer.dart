import 'package:flutter/material.dart';

class DisclaimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              'Acknowledgement',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "I want to extend my heartfelt appreciation to Matthew, Peter, and my supervisor, Dr. Azfar Khalid, for their invaluable contributions to the development and improvement of StressSense. Their guidance, feedback, and suggestions have been instrumental in shaping this app into a meaningful resource for stress management. I would also like to express my gratitude to Arshia for her significant contribution to this project. Her dedication and efforts have played a vital role in making StressSense a reality.",
            textAlign: TextAlign.justify,
          ),
          Text(
            "Best regards",
            textAlign: TextAlign.justify,
          ),
          Text(
            "Mathew Ogbonnia Otu",
            textAlign: TextAlign.justify,
          ),
  
          // Add more Widgets as needed
        ],
      ),
    );
  }
}
