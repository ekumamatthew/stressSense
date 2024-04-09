import 'package:flutter/material.dart';
import 'package:stressSense_lab/widgets/speedometer/customPaint.dart';

class SpeedometerWidget extends StatelessWidget {
  final double averageNASA;

  const SpeedometerWidget({Key? key, required this.averageNASA})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: CustomPaint(
        painter: SpeedometerPainter(value: averageNASA),
      ),
    );
  }
}
