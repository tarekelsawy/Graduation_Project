import 'dart:async';

import 'package:corona_test_project/modules/on_boarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CoronaSplashScreen extends StatefulWidget {
  const CoronaSplashScreen({Key? key}) : super(key: key);

  @override
  State<CoronaSplashScreen> createState() => _CoronaSplashScreenState();
}

class _CoronaSplashScreenState extends State<CoronaSplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(
      seconds: 3,
    ),
  )..repeat();

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 5,
        ), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return OnBoardingScreen();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedBuilder(
                animation: _animationController,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image(
                    image: AssetImage('assets/images/corona.jpg'),
                  ),
                ),
                builder: (
                  BuildContext context,
                  Widget? child,
                ) {
                  return Transform.rotate(
                    angle: _animationController.value * 2.0 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            const Text(
              'Covid-19 Suspection',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
