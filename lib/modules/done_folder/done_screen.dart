import 'package:corona_test_project/modules/done_folder/final_done_Screen.dart';
import 'package:corona_test_project/modules/get_image/get_image_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBarScreen(),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: isDark ? colorBlack : colorWhite,
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 117, 117, 117),
                            Color.fromARGB(255, 117, 117, 117),
                            isDark ? colorYellow : colorPurple,
                          ],
                          stops: [
                            0,
                            0.3,
                            0.5
                          ]),
                    ),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.done,
                        size: 100,
                        color: isDark ? Colors.grey[600] : colorPurple,
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
                    )),
              ),
            ),
            SizedBox(
              height: 40,
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
                        navigateTo(context: context, widget: GetImageScreen());
                      },
                      child: Text(
                        'Choose MRI Image',
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
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
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
                        navigateTo(
                          context: context,
                          widget: FinalDoneScreen(),
                        );
                      },
                      child: Text(
                        'Skip',
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

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Colors.blue, Colors.red],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
