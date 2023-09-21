import 'package:flutter/material.dart';

class ImageOverlayWidget extends StatefulWidget {
  @override
  _ImageOverlayWidgetState createState() => _ImageOverlayWidgetState();
}

class _ImageOverlayWidgetState extends State<ImageOverlayWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool isOverlayVisible = false;
  Offset overlayPosition = const Offset(0, 0);
  double maxRadius = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void toggleOverlay(Offset position) {
    setState(() {
      if (!isOverlayVisible) {
        overlayPosition = position;
        maxRadius = MediaQuery.of(context).size.height;
        _controller!.forward();
      } else {
        overlayPosition = position;
        _controller!.reverse();
      }
      isOverlayVisible = !isOverlayVisible;
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapUp: (details) {
            toggleOverlay(details.localPosition);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'images/background.jpg', // Replace with your image URL
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              AnimatedBuilder(
                animation: _controller!,
                builder: (context, child) {
                  return ClipPath(
                    clipper: CustomCircleClipper(
                      _controller!.value, // The current animation value
                      overlayPosition,
                      maxRadius,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(4, 5),
                            color: Colors.grey,
                            blurRadius: maxRadius * _controller!.value,
                            spreadRadius: maxRadius * _controller!.value,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCircleClipper extends CustomClipper<Path> {
  final double animationValue;
  final Offset position;
  final double maxRadius;

  CustomCircleClipper(this.animationValue, this.position, this.maxRadius);

  @override
  Path getClip(Size size) {
    final currentRadius = maxRadius * animationValue;
    final dx = position.dx;
    final dy = position.dy;

    final path = Path();
    path.addOval(
        Rect.fromCircle(center: Offset(dx, dy), radius: currentRadius));
    path.addRect(
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)));
    return path..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
