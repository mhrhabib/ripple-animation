import 'package:flutter/material.dart';
import 'dart:math';

class RotateAnimationScreen extends StatefulWidget {
  const RotateAnimationScreen({super.key});

  @override
  State<RotateAnimationScreen> createState() => _RotateAnimationScreenState();
}

class _RotateAnimationScreenState extends State<RotateAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        Tween<double>(begin: 0.0, end: pi * 2).animate(_animationController);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateZ(_animation.value),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
