import 'package:corona_test_project/modules/done_folder/done_screen.dart';
import 'package:corona_test_project/modules/result_screen/corona_result_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';

import '../sidebar_screen/sidebar_screen.dart';

class FinalDoneScreen extends StatelessWidget {
  const FinalDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBarScreen(),
      // backgroundColor: Color(0xFF1C1C1C),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 171.0,
              color: isDark ? colorBlack : colorWhite,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: isDark ? colorYellow : colorPurple,
                child: CircleAvatar(
                  child: Icon(
                    Icons.done_all,
                    size: 100,
                    color: isDark ? colorYellow : colorPurple,
                  ),
                  // child: Text(
                  //   'DONE',
                  //   style: TextStyle(
                  //     fontSize: 40,
                  //     fontFamily: 'Lato',
                  //     fontWeight: FontWeight.bold,
                  //     color: Color(0xFFF3D657),
                  //   ),
                  // ),
                  backgroundColor: isDark ? colorBlack : colorWhite,
                  radius: 83,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 4,
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
                        navigateTo(context: context, widget: ResultScreen());
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
                      // highlightColor: Color(0xFFF3D657),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: isDark ? colorBlack : colorWhite,
              ),
              backgroundColor: isDark ? colorYellow : colorPurple,
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
