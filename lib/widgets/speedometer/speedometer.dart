import 'package:flutter/material.dart';
import 'package:stressSense/theme/colors.dart';
import 'package:stressSense/widgets/speedometer/customPaint.dart';

class SpeedometerWidget extends StatelessWidget {
  final double initalAverageValue;
  final double finalAverageValue;

  const SpeedometerWidget({
    super.key,
    required this.initalAverageValue,
    required this.finalAverageValue,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double widgetWidth = constraints.maxWidth * 0.7;
        double widgetHeight = widgetWidth;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: widgetWidth,
                  height: widgetHeight,
                  child: CustomPaint(
                    painter: SpeedometerPainter(value: finalAverageValue),
                  ),
                ),
                Text(
                  'Stress Level After Task: ${finalAverageValue.isFinite ? finalAverageValue.toStringAsFixed(2) : '0'}',
                  style: const TextStyle(
                    color: AppColor.gray,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
