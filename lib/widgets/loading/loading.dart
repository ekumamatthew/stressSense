import 'package:flutter/material.dart';

class PulsingAnimationWidget extends StatefulWidget {
  const PulsingAnimationWidget({super.key});

  @override
  _PulsingAnimationWidgetState createState() => _PulsingAnimationWidgetState();
}

class _PulsingAnimationWidgetState extends State<PulsingAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.6, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.3;
    return Stack(
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: Opacity(
              opacity: 0.5,
              child: Container(color: Colors.grey),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: SizedBox(
                width: size,
                height: size,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(50), // Adjust the radius as needed
                  child: Image.asset(
                    'assets/images/logoImages/neurotrack.jpg',
                    fit: BoxFit
                        .cover, // Makes sure the image covers the entire space
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
