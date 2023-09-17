import 'package:flutter/material.dart';

class SplashLoader extends StatefulWidget {
  const SplashLoader({super.key});

  @override
  SplashLoaderState createState() => SplashLoaderState();
}

class SplashLoaderState extends State<SplashLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              painter: LockScreenPainter(_animation.value),
              child: const SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: Icon(
                    Icons.lock,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LockScreenPainter extends CustomPainter {
  final double progress;

  LockScreenPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.4;
    final sweepAngle = 2 * 3.1415927 * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1415927 / 4,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
