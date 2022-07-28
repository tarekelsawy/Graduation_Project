import 'package:corona_test_project/modules/corona_test_screens/questions_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';

class StastTestScreen extends StatelessWidget {
  const StastTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBarScreen(),
      appBar: AppBar(
        title: Title(
          child: const Text(
            'Start Test',
          ),
          color: isDark ? colorYellow : colorPurple,
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getProgressBar(isStartScreen: true),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image.asset(
                    'assets/icons/virus_alt_Large.png',
                    color: isDark ? colorYellow : colorPurple,
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Covid-19',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20.0,
                        color: isDark ? colorYellow : colorPurple,
                      ),
                ),
                Text(
                  'Assessment Test',
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 20.0,
                        color: isDark ? colorYellow : colorPurple,
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
                    navigateTo(context: context, widget: QuestionTestScreen());
                  },
                  child: Text(
                    'Start',
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
