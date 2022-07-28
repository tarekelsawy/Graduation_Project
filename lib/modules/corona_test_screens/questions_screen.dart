import 'package:corona_test_project/generated/l10n.dart';
import 'package:corona_test_project/modules/done_folder/done_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../clip_path/clip_paths.dart';

/**
 * 1-grediant color 
 * 2-prefix and suffix text in slider
 * 
 */

class QuestionModel {
  String question;
  int divisions;
  double min;
  double max;
  double initValue;
  String prefixText;
  String postFixText;
  String image;
  QuestionModel({
    required this.question,
    required this.divisions,
    required this.max,
    required this.min,
    required this.initValue,
    required this.postFixText,
    required this.prefixText,
    required this.image,
  });
}

class QuestionTestScreen extends StatelessWidget {
  PageController questionController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    bool isLastPage = false;
    List<QuestionModel> questionsList = [
      QuestionModel(
        question: S.of(context).q1,
        divisions: 100,
        max: 42,
        min: 37,
        initValue: 37,
        postFixText: S.of(context).high,
        prefixText: S.of(context).normal,
        image: 'assets/icons/sick.png',
      ),
      //prefix ->normal ---post high
      QuestionModel(
        question: S.of(context).q2,
        divisions: 3,
        max: 1,
        min: 0,
        initValue: 0,
        postFixText: S.of(context).yes,
        prefixText: S.of(context).no,
        image: 'assets/icons/cough (2).png',
      ),
      //display the sumb in center
      QuestionModel(
        question: S.of(context).q3,
        divisions: 3,
        max: 1,
        min: 0,
        initValue: 0,
        postFixText: S.of(context).wholeBody,
        prefixText: S.of(context).noneTired,
        image: 'assets/icons/tiredness.png',
      ),
      QuestionModel(
        question: S.of(context).q4,
        divisions: 3,
        max: 1,
        min: 0,
        initValue: 0,
        postFixText: S.of(context).high,
        prefixText: S.of(context).low,
        image: 'assets/icons/sick (2).png',
      ),
      QuestionModel(
        question: S.of(context).q5,
        divisions: 3,
        max: 1,
        min: 0,
        initValue: 0,
        postFixText: S.of(context).hard,
        prefixText: S.of(context).easy,
        image: 'assets/icons/difficulty-breathing.png',
      ),
      QuestionModel(
        question: S.of(context).q6,
        divisions: 3,
        max: 1,
        min: 0,
        initValue: 0,
        postFixText: S.of(context).paintful,
        prefixText: S.of(context).nopain,
        image: 'assets/icons/headache@2x.png',
      ),
      QuestionModel(
        question: S.of(context).q7,
        divisions: 3,
        max: 1,
        min: 0,
        initValue: 0,
        postFixText: S.of(context).runny,
        prefixText: S.of(context).no,
        image: 'assets/icons/sick (2).png',
      ),
      QuestionModel(
        question: S.of(context).q8,
        divisions: 3,
        max: 1,
        min: 0,
        initValue: 0,
        postFixText: S.of(context).paintful,
        prefixText: S.of(context).nopain,
        image: 'assets/icons/chest-pain-or-pressure.png',
      ),
    ];
    return BlocConsumer<CoronaCubit, CoronaStates>(
      listener: (context, state) {
        if (state is CoronaUploadQuestionToFirebaseSuccessState) {
          showToast(
              message: 'Your Anwers Uploaded Successfully',
              toastStatus: ToastStatus.SUCCESS);
          navigateTo(context: context, widget: DoneScreen());
        }
      },
      builder: (context, state) {
        S locale = S.of(context);
        CoronaCubit cubit = CoronaCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Title(
              child: Text('Test'),
              color: isDark ? colorWhite : colorPurple,
            ),
          ),
          drawer: SideBarScreen(),
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: isDark ? colorYellow : colorWhite,
                ),
                Column(
                  children: [
                    getProgressBar(isQuestionScreen: true),
                    Expanded(
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: questionController,
                        onPageChanged: (int index) {
                          if (index == questionsList.length - 1) {
                            isLastPage = true;
                          } else {
                            isLastPage = false;
                          }
                          cubit.onChangeQuestionPageIndex(
                            newIndex: index,
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return pageItem(
                            model: questionsList[index],
                            context: context,
                            cubit: cubit,
                            index: index,
                          );
                        },
                        itemCount: questionsList.length,
                      ),
                    ),
                    ClipPath(
                      clipper: Clip2(),
                      child: Container(
                        width: double.infinity,
                        height: 160,
                        color: isDark ? colorBlack : colorPurple,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: "btn1",
                                  onPressed: () {
                                    questionController.previousPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInToLinear);
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: isDark ? colorBlack : colorPurple,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  currentLanguage == 'en'
                                      ? '${CoronaCubit.questionPageIndex + 1}' +
                                          '/' +
                                          '${questionsList.length}'
                                      : convertStringToNumber(
                                              '${CoronaCubit.questionPageIndex + 1}') +
                                          '\\' +
                                          convertStringToNumber(
                                              '${questionsList.length}'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color:
                                            isDark ? colorYellow : colorWhite,
                                      ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                state !=
                                        CoronaUploadQuestionToFirebaseLoadingState
                                    ? FloatingActionButton(
                                        heroTag: "btn2",
                                        onPressed: () {
                                          if (isLastPage == true) {
                                            for (int i = 0; i < 8; ++i) {
                                              CoronaCubit.qResult[i] =
                                                  formatSliderDataForFirebase(
                                                      cubit.qValues[i]);
                                            }

                                            CoronaCubit.qPresult = 0;
                                            for (int i = 0; i < 8; ++i) {
                                              CoronaCubit.qCounters[i] =
                                                  getCounterData(
                                                      i, cubit.qValues[i]);
                                              CoronaCubit.qPresult +=
                                                  CoronaCubit.qCounters[i];
                                            }
                                            print(
                                                'qPreselt = ${CoronaCubit.qPresult}');
                                            cubit
                                                .uploadQuestionDataToFireStore();
                                          } else {
                                            questionController.nextPage(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.easeInToLinear);
                                          }
                                        },
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            color: isDark
                                                ? colorBlack
                                                : colorPurple,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 25.0,
                            ),
                          ],
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget pageItem({
  required QuestionModel model,
  required BuildContext context,
  required CoronaCubit cubit,
  required int index,
}) {
  return Container(
    color: isDark ? colorYellow : colorWhite,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10.0,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
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
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5.0,
                      ),
                      child: Container(
                        child: Image.asset(
                          '${model.image}',
                          color: colorYellow,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 8.0,
                      ),
                      child: Center(
                        child: Text(
                          model.question,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 15,
                                    color: isDark ? colorYellow : colorWhite,
                                  ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              children: [
                Text(
                  model.prefixText,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorBlack,
                        fontSize: 6,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      valueIndicatorColor:
                          selectColor(index: index, value: cubit.qValues[index])
                              ? Color.fromARGB(255, 231, 17, 2)
                              : getColor(),
                      valueIndicatorTextStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: colorWhite,
                              ),
                      thumbColor:
                          selectColor(index: index, value: cubit.qValues[index])
                              ? Color.fromARGB(255, 231, 17, 2)
                              : getColor(),
                      overlayColor:
                          selectColor(index: index, value: cubit.qValues[index])
                              ? Color.fromARGB(255, 231, 17, 2)
                              : getColor(),
                      activeTrackColor: getColor(),
                      inactiveTickMarkColor: getColor(),
                    ),
                    child: Slider(
                      value: cubit.qValues[index],
                      onChanged: (newValue) {
                        cubit.onChangeSliderValue(
                            newValue: newValue, index: index);
                      },
                      min: model.min,
                      max: model.max,
                      divisions: model.divisions,
                      label: selectLabel(
                        index: index,
                        value: cubit.qValues[index],
                      ),
                    ),
                  ),
                ),
                Text(
                  model.postFixText,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorBlack,
                        fontSize: 6,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// class Clip1 extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(0, size.height);
//     path.quadraticBezierTo(
//         size.width * 0.5, size.height - 110, size.width, size.height);
//     path.lineTo(size.width, 0);
//     path.close;

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper oldClipper) {
//     // TODO: implement shouldReclip
//     throw UnimplementedError();
//   }
// }
Color getColor() {
  return isDark ? colorBlack : colorPurple;
}

String convertStringToNumber(String s) {
  late String number;
  switch (s) {
    case '1':
      number = '١';
      break;
    case '2':
      number = '٢';
      break;
    case '3':
      number = '٣';
      break;
    case '4':
      number = '٤';
      break;
    case '5':
      number = '٥';
      break;
    case '6':
      number = '٦';
      break;
    case '7':
      number = '٧';
      break;
    case '8':
      number = '٨';
      break;
    case '9':
      number = '٩';
      break;
    case '10':
      number = '١٠';
      break;
  }
  return number;
}

bool selectColor({
  required int index,
  required double value,
}) {
  bool flag = false;
  switch (index) {
    case 0:
      if (value > 38.5) flag = true;
      break;
    case 1:
      flag = valueBetween(value, 0.60, 1.0);
      break;
    case 2:
      flag = valueBetween(value, 0.60, 1.0);
      break;
    case 3:
      flag = valueBetween(value, 0.60, 1.0);
      break;
    case 4:
      flag = valueBetween(value, 0.60, 1.0);
      break;
    case 5:
      flag = valueBetween(value, 0.60, 1.0);
      break;
    case 6:
      flag = valueBetween(value, 0.60, 1.0);
      break;
    case 7:
      flag = valueBetween(value, 0.60, 1.0);
      break;
  }
  return flag;
}

bool valueBetween(double v1, double v2, double v3) {
  return v1 > v2 && v1 <= v3 ? true : false;
}

String selectLabel({
  required int index,
  required double value,
}) {
  String result = '';
  print('$index ->$value');
  switch (index) {
    case 0:
      result = '${value.toStringAsFixed(2)}';
      break;
    case 1:
      if (valueBetween(value, -0.1, 0.29)) result = 'no-tired';
      if (valueBetween(value, 0.3, 0.35)) result = 'semi-tired';
      if (valueBetween(value, 0.6, 0.69)) result = 'tired';
      if (valueBetween(value, 0.9, 1.0)) result = 'very-tired';
      break;
    case 2:
      if (valueBetween(value, -0.1, 0.29)) result = 'no-tired';
      if (valueBetween(value, 0.3, 0.35)) result = 'semi-tired';
      if (valueBetween(value, 0.6, 0.69)) result = 'tired';
      if (valueBetween(value, 0.9, 1.0)) result = 'very-tired';
      break;
    case 4:
      if (valueBetween(value, -0.1, 0.29)) result = 'no-tired';
      if (valueBetween(value, 0.3, 0.35)) result = 'semi-tired';
      if (valueBetween(value, 0.6, 0.69)) result = 'tired';
      if (valueBetween(value, 0.9, 1.0)) result = 'very-tired';
      break;
    case 3:
      if (valueBetween(value, -0.1, 0.29)) result = 'no-tired';
      if (valueBetween(value, 0.3, 0.35)) result = 'no-smell';
      if (valueBetween(value, 0.6, 0.69)) result = 'no-taste';
      if (valueBetween(value, 0.9, 1.0)) result = 'no-both';
      break;
    case 5:
      if (valueBetween(value, -0.1, 0.29)) result = 'no-tired';
      if (valueBetween(value, 0.3, 0.35)) result = 'semi-tired';
      if (valueBetween(value, 0.6, 0.69)) result = 'tired';
      if (valueBetween(value, 0.9, 1.0)) result = 'very-tired';
      break;
    case 6:
      if (valueBetween(value, -0.1, 0.29)) result = 'no-tired';
      if (valueBetween(value, 0.3, 0.35)) result = 'semi-tired';
      if (valueBetween(value, 0.6, 0.69)) result = 'tired';
      if (valueBetween(value, 0.9, 1.0)) result = 'very-tired';
      break;
    case 7:
      if (valueBetween(value, -0.1, 0.29)) result = 'no-tired';
      if (valueBetween(value, 0.3, 0.35)) result = 'semi-tired';
      if (valueBetween(value, 0.6, 0.69)) result = 'tired';
      if (valueBetween(value, 0.9, 1.0)) result = 'very-tired';
      break;
  }
  return result;
}

String formatSliderDataForFirebase(double vr) {
  late String tmp;
  if (vr <= 1.0) {
    if (vr >= 0.0 && vr <= 0.6) tmp = 'no';
    if (vr > 0.6 && vr <= 0.85) tmp = 'some';
    if (vr > 0.85 && vr <= 1.0) tmp = 'dying';
  } else {
    if (vr >= 37.0 && vr <= 38.3) tmp = 'no';
    if (vr > 38.3 && vr <= 39.85) tmp = 'some';
    if (vr > 39.85 && vr <= 42.0) tmp = 'dying';
  }

  return tmp;
}

double getCounterData(int index, double value) {
  late double result;
  switch (index) {
    case 0:
      result = isTemp(value);
      break;
    case 1:
      if (valueBetween(value, -0.1, 0.29)) result = 1.75;
      if (valueBetween(value, 0.3, 0.35)) result = 3.5;
      if (valueBetween(value, 0.6, 0.69)) result = 5.25;
      if (valueBetween(value, 0.9, 1.0)) result = 7.0;
      break;
    case 2:
      if (valueBetween(value, -0.1, 0.29)) result = 1.75;
      if (valueBetween(value, 0.3, 0.35)) result = 3.5;
      if (valueBetween(value, 0.6, 0.69)) result = 5.25;
      if (valueBetween(value, 0.9, 1.0)) result = 7.0;
      break;
    case 4:
      if (valueBetween(value, -0.1, 0.29)) result = 3;
      if (valueBetween(value, 0.3, 0.35)) result = 6;
      if (valueBetween(value, 0.6, 0.69)) result = 9;
      if (valueBetween(value, 0.9, 1.0)) result = 12;
      break;
    case 3:
      if (valueBetween(value, -0.1, 0.29)) result = 1.75;
      if (valueBetween(value, 0.3, 0.35)) result = 3.5;
      if (valueBetween(value, 0.6, 0.69)) result = 5.25;
      if (valueBetween(value, 0.9, 1.0)) result = 7.0;
      break;
    case 5:
      if (valueBetween(value, -0.1, 0.29)) result = 1;
      if (valueBetween(value, 0.3, 0.35)) result = 2;
      if (valueBetween(value, 0.6, 0.69)) result = 3;
      if (valueBetween(value, 0.9, 1.0)) result = 4;
      break;
    case 6:
      if (valueBetween(value, -0.1, 0.29)) result = 1;
      if (valueBetween(value, 0.3, 0.35)) result = 2;
      if (valueBetween(value, 0.6, 0.69)) result = 3;
      if (valueBetween(value, 0.9, 1.0)) result = 4;
      break;
    case 7:
      if (valueBetween(value, -0.1, 0.29)) result = 3;
      if (valueBetween(value, 0.3, 0.35)) result = 6;
      if (valueBetween(value, 0.6, 0.69)) result = 9;
      if (valueBetween(value, 0.9, 1.0)) result = 12;
      break;
  }
  return result;
}

double isTemp(double value) {
  late double result;
  if (value >= 37 && value <= 38) {
    result = 1.4;
  }
  if (value > 38 && value <= 39) {
    result = 2.8;
  }
  if (value > 39 && value <= 40) {
    result = 4.2;
  }
  if (value > 40 && value <= 41) {
    result = 5.6;
  }
  if (value > 41 && value <= 42) {
    result = 7.0;
  }
  return result;
}
