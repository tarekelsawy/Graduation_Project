import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';

class ResultIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Result',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 40.0,
                color: isDark ? colorYellow : colorPurple,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 25,
        ),
        CircleAvatar(
          child: Text(
            '70%',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontSize: 40,
                  color: isDark ? colorYellow : colorWhite,
                ),
          ),
          radius: 68,
          backgroundColor: isDark ? colorBlack : colorPurple,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'You should see a doctor',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 20.0,
                color: isDark ? colorBlack : colorPurple,
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
