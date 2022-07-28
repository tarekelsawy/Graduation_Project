import 'package:corona_test_project/modules/result/result_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UnDetailedResultScreen extends StatelessWidget {
  const UnDetailedResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCovid = double.parse(CoronaCubit.imageCovidPercent ?? '0.0') * 0.4 +
                CoronaCubit.qPresult >=
            70 ||
        double.parse(CoronaCubit.imageCovidPercent ?? '0.0') > 80 ||
        (double.parse(CoronaCubit.imageCovidPercent ?? '0.0') > 60 &&
            CoronaCubit.qPresult > 40) ||
        (CoronaCubit.imageCovidPercent == null && CoronaCubit.qPresult > 45);
    return Scaffold(
      drawer: SideBarScreen(),
      appBar: AppBar(
        title: Title(
          child: Text('Suspection Result'),
          color: isDark ? colorYellow : colorPurple,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? colorYellow : colorPurple,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Covid-19 Suspection',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isDark ? colorYellow : colorPurple,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    isCovid ? 'Positive' : 'Negative',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isCovid ? colorRed : colorGreen,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Container(
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
                  navigateTo(context: context, widget: ResultTestScreen());
                },
                child: Text(
                  'See Details',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: isDark ? colorYellow : colorWhite,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                elevation: 15.0,
                highlightElevation: 5.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
