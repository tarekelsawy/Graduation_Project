import 'package:corona_test_project/modules/corona_test_screens/questions_screen.dart';
import 'package:corona_test_project/modules/done_folder/final_done_Screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:corona_test_project/generated/l10n.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            S.of(context).details,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: isDark ? colorYellow : colorWhite,
                  fontSize: 27,
                ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "1 Provide, operate, and maintain our website",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorYellow : colorWhite,
                            height: 2.5,
                          ),
                    ),
                    Text(
                      "2 Provide, operate, and maintain our website",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorYellow : colorWhite,
                            height: 2.5,
                          ),
                    ),
                    Text(
                      "3 Provide, operate, and maintain our website",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorYellow : colorWhite,
                            height: 2.5,
                          ),
                    ),
                    Text(
                      "2 Provide, operate, and maintain our website",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorYellow : colorWhite,
                            height: 2.5,
                          ),
                    ),
                    Text(
                      "3 Provide, operate, and maintain our website",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorYellow : colorWhite,
                            height: 2.5,
                          ),
                    ),
                    Text(
                      "2 Provide, operate, and maintain our website",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorYellow : colorWhite,
                            height: 2.5,
                          ),
                    ),
                    Text(
                      "3 Provide, operate, and maintain our website",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorYellow : colorWhite,
                            height: 2.5,
                          ),
                    ),
                    Text(
                      "2 Provide, operate, and maintain our website",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorYellow : colorWhite,
                            height: 2.5,
                          ),
                    ),
                    Text(
                      "3 Provide, operate, and maintain our website",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorYellow : colorWhite,
                            height: 2.5,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: 'tag1',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: isDark ? colorBlack : colorPurple,
                      size: 35,
                    ),
                  ),
                  backgroundColor: isDark ? colorYellow : colorWhite,
                ),
                SizedBox(
                  width: 50,
                ),
                FloatingActionButton(
                  heroTag: 'tag2',
                  onPressed: () {},
                  child: Center(
                    child: Icon(
                      Icons.home,
                      color: isDark ? colorBlack : colorPurple,
                    ),
                  ),
                  backgroundColor: isDark ? colorYellow : colorWhite,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
