import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';

class DetailsOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.keyboard_arrow_up_outlined,
          size: 30,
          color: isDark ? colorYellow : colorWhite,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Details',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: isDark ? colorYellow : colorWhite,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
