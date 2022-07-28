import 'package:corona_test_project/modules/corona_test_screens/questions_screen.dart';
import 'package:corona_test_project/modules/result/result_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/modules/undetailed_result_screen/undetailed_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';

class TestCompletedScreen extends StatelessWidget {
  const TestCompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarScreen(),
      appBar: AppBar(
        title: Title(
          child: const Text(
            'Test Completed',
          ),
          color: colorYellow,
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getProgressBar(
              isDoneScreen: true,
              isGetImageScreen: true,
              isTestCompletedScreen: true,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(
                    'assets/icons/work-done.png',
                    color: colorGreen,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Test Completed',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20.0,
                        color: colorGreen,
                      ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? colorBlack : colorPurple,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  border: Border.all(
                    color: isDark ? colorYellow : colorPurple,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Color.fromARGB(255, 117, 105, 51)
                          : colorPurple.withOpacity(0.9),
                      spreadRadius: 1.0,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: MaterialButton(
                  onPressed: () {
                    navigateTo(
                        context: context, widget: UnDetailedResultScreen());
                  },
                  child: Text(
                    'Result',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: isDark ? colorYellow : colorWhite,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  elevation: 25.0,
                  highlightElevation: 10.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
