import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Existing User?',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: colorBlack,
              ),
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: colorBlack,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: colorBlack.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 4,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: colorYellow,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
