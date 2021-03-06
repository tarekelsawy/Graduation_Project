import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:corona_test_project/generated/l10n.dart';

class ResultOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          S.of(context).result,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: isDark ? colorBlack : colorPurple,
              ),
        ),
        Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 30,
          color: isDark ? colorBlack : colorPurple,
        ),
      ],
    );
  }
}
