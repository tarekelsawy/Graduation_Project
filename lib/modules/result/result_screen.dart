import 'package:corona_test_project/modules/get_image/get_image_screen.dart';
import 'package:corona_test_project/modules/review/review.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/cubit.dart';
import 'package:corona_test_project/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoronaCubit, CoronaStates>(
      listener: (context, state) {
        if (state is CoronaUploadTestResultToFirebaseSuccessState) {
          print('toast saved result');
          showToast(
              message: 'your Result Uploaded Successfully',
              toastStatus: ToastStatus.SUCCESS);
          navigateTo(context: context, widget: ReviewScreen());
        }
      },
      builder: (context, state) {
        CoronaCubit cubit = CoronaCubit.get(context);
        return Scaffold(
          drawer: SideBarScreen(),
          appBar: AppBar(
            title: Title(
              child: Text('Result'),
              color: isDark ? colorYellow : colorPurple,
            ),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark ? colorYellow : colorPurple,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Test Result',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: isDark ? colorYellow : colorPurple,
                            ),
                      ),
                      Divider(
                        color: isDark ? colorYellow : colorPurple,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                '${testText(CoronaCubit.qPresult / 60 * 100)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: isDark ? colorYellow : colorPurple,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: CircularPercentIndicator(
                                radius: 56.0,
                                lineWidth: 10.0,
                                percent: (CoronaCubit.qPresult / 60),
                                center: Text(
                                  "%${(CoronaCubit.qPresult / 60 * 100).toStringAsFixed(1)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color:
                                            isDark ? colorYellow : colorPurple,
                                        fontSize: 16.0,
                                      ),
                                ),
                                circularStrokeCap: CircularStrokeCap.butt,
                                backgroundColor:
                                    isDark ? colorYellow : colorPurple,
                                progressColor: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              if (CoronaCubit.imageCovidPercent != null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark ? colorYellow : colorPurple,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'MRI Image',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: isDark ? colorYellow : colorPurple,
                                  ),
                        ),
                        Divider(
                          color: isDark ? colorYellow : colorPurple,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Text(
                                  '${testText(double.parse(CoronaCubit.imageCovidPercent ?? '0.0'))}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color:
                                            isDark ? colorYellow : colorPurple,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: CircularPercentIndicator(
                                  radius: 56.0,
                                  lineWidth: 10.0,
                                  percent: (CoronaCubit.imageCovidPercent !=
                                          null)
                                      ? double.parse(
                                              CoronaCubit.imageCovidPercent ??
                                                  '0.0') /
                                          100
                                      : 0.0,
                                  center: Text(
                                    "%${(double.parse(CoronaCubit.imageCovidPercent ?? '0.0')).toStringAsFixed(1)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: isDark
                                              ? colorYellow
                                              : colorPurple,
                                          fontSize: 16.0,
                                        ),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.butt,
                                  backgroundColor:
                                      isDark ? colorYellow : colorPurple,
                                  progressColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (CoronaCubit.imageCovidPercent != null)
                SizedBox(
                  height: 20.0,
                ),
              if (CoronaCubit.imageCovidPercent != null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark ? colorYellow : colorPurple,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Final Result',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: isDark ? colorYellow : colorPurple,
                                  ),
                        ),
                        Divider(
                          color: isDark ? colorYellow : colorPurple,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Text(
                                  'You have common Symptoms of infection',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color:
                                            isDark ? colorYellow : colorPurple,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: CircularPercentIndicator(
                                  radius: 56.0,
                                  lineWidth: 10.0,
                                  percent: (double.parse(
                                              CoronaCubit.imageCovidPercent ??
                                                  '0.0') /
                                          100 *
                                          0.4) +
                                      ((CoronaCubit.qPresult / 60) * 0.6),
                                  center: Text(
                                    "%${((double.parse(CoronaCubit.imageCovidPercent ?? '0.0') * 0.4) + (CoronaCubit.qPresult)).toStringAsFixed(1)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: isDark
                                              ? colorYellow
                                              : colorPurple,
                                          fontSize: 16.0,
                                        ),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.butt,
                                  backgroundColor:
                                      isDark ? colorYellow : colorPurple,
                                  progressColor: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              if (CoronaCubit.imageCovidPercent == null)
                SizedBox(
                  height: 20.0,
                ),
              if (CoronaCubit.imageCovidPercent == null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark ? colorYellow : colorPurple,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recommended',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: isDark ? colorYellow : colorPurple,
                                  ),
                        ),
                        Divider(
                          color: isDark ? colorYellow : colorPurple,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Image.asset(
                                  'assets/icons/xray@2x.png',
                                  color: isDark ? colorYellow : colorPurple,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      'Use MRI Image Will Enhance Result',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: isDark
                                                ? colorYellow
                                                : colorPurple,
                                            fontSize: 15.0,
                                          ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: isDark ? colorBlack : colorPurple,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      border: Border.all(
                                        color:
                                            isDark ? colorYellow : colorPurple,
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: isDark
                                              ? Color.fromARGB(
                                                  255, 117, 105, 51)
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
                                            widget: GetImageScreen());
                                      },
                                      child: Text(
                                        'MRI Image',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: isDark
                                                  ? colorYellow
                                                  : colorWhite,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      elevation: 15.0,
                                      highlightElevation: 5.0,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isDark ? colorYellow : colorPurple,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Recommended',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: isDark ? colorYellow : colorPurple,
                            ),
                      ),
                      Divider(
                        color: isDark ? colorYellow : colorPurple,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Image.asset(
                                'assets/icons/xray@2x.png',
                                color: isDark ? colorYellow : colorPurple,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Your Review Is Important For Us',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: isDark
                                              ? colorYellow
                                              : colorPurple,
                                          fontSize: 15.0,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
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
                                    onPressed: () {},
                                    child: Text(
                                      'Review',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: isDark
                                                ? colorYellow
                                                : colorWhite,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    elevation: 15.0,
                                    highlightElevation: 5.0,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              state is! CoronaUploadTestResultToFirebaseLoadingState
                  ? Container(
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
                          cubit.uploadTestResultDataToFireStore(
                              res: isCovid() ? 'Yes' : 'No');
                        },
                        child: Text(
                          'Save',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: isDark ? colorYellow : colorWhite,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        elevation: 15.0,
                        highlightElevation: 5.0,
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
        );
      },
    );
  }
}

bool isCovid() {
  print('in covid');
  return double.parse(CoronaCubit.imageCovidPercent ?? '0.0') * 0.4 +
              CoronaCubit.qPresult >=
          70 ||
      double.parse(CoronaCubit.imageCovidPercent ?? '0.0') > 80 ||
      (double.parse(CoronaCubit.imageCovidPercent ?? '0.0') > 60 &&
          CoronaCubit.qPresult > 40) ||
      (CoronaCubit.imageCovidPercent == null && CoronaCubit.qPresult > 45);
}

String testText(double input) {
  late String res;
  if (input >= 0.0 && input <= 33.33) {
    res = 'You have little common symptoms of the virus';
  } else if (input > 33.33 && input <= 66.66) {
    res = 'You have some common symptoms, you need to be careful';
  } else if (input > 66.66 && input <= 100) {
    res =
        'You have most of the common symptoms , you should consult your doctor ';
  }
  return res;
}
