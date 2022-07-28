import 'dart:math';

import 'package:flutter/cupertino.dart';

class SlideAnimation extends PageRouteBuilder {
  final page;
  SlideAnimation(this.page)
      : super(
          pageBuilder: (context, animaion, secondAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeIn;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
        );
}
