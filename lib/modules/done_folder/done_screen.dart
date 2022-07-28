import 'package:corona_test_project/generated/l10n.dart';
import 'package:corona_test_project/modules/done_folder/final_done_Screen.dart';
import 'package:corona_test_project/modules/get_image/get_image_screen.dart';
import 'package:corona_test_project/modules/result/result_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBarScreen(),
      appBar: AppBar(
        title: Title(
          color: colorYellow,
          child: Text(
            'Test',
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          child: Column(
            children: [
              getProgressBar(
                isDoneScreen: true,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorYellow,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF1C1C1C).withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: isDark ? colorBlack : colorWhite,
                ),
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.28,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorYellow,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1C1C1C).withOpacity(0.2),
                              spreadRadius: 3.0,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: isDark ? colorBlack : colorPurple,
                        ),
                        child: Image.asset(
                          'assets/icons/xray@2x.png',
                          color: colorYellow,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                        ),
                        decoration: BoxDecoration(
                          color: isDark ? colorBlack : colorPurple,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
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
                                context: context, widget: GetImageScreen());
                          },
                          child: Text(
                            S.of(context).image,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: isDark ? colorYellow : colorWhite,
                                      fontSize:
                                          currentLanguage == 'en' ? 22.0 : 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          elevation: 25.0,
                          highlightElevation: 10.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
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
                              pop(context);
                            },
                            child: Text(
                              S.of(context).back,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
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
                        child: Container(),
                      ),
                      Expanded(
                        flex: 2,
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
                                widget: ResultTestScreen(),
                              );
                            },
                            child: Text(
                              S.of(context).skip,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
