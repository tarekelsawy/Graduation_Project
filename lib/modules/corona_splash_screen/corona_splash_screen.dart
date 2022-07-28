import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CoronaTestSplashScreen extends StatefulWidget {
  final startScreen;

  const CoronaTestSplashScreen({Key? key, required this.startScreen})
      : super(key: key);

  @override
  State<CoronaTestSplashScreen> createState() => _CoronaTestSplashScreenState();
}

class _CoronaTestSplashScreenState extends State<CoronaTestSplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 5,
        ), () {
      navigateAndFinish(context: context, widget: widget.startScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Lottie.asset(
                'assets/icons/animation_splash.json',
              ),
            ),
            Container(
              child: Image.asset(
                'assets/icons/COVID-19 SUSPECTION TEST-logos_black1.png',
                width: double.infinity,
                height: 60.0,
                color: colorYellow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
