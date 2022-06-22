import 'package:corona_test_project/generated/l10n.dart';
import 'package:corona_test_project/modules/done_folder/done_screen.dart';
import 'package:corona_test_project/modules/get_image/get_image_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
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
  double min;
  double max;
  double initValue;
  String prefixText;
  String postFixText;
  QuestionModel(
      {required this.question,
      required this.max,
      required this.min,
      required this.initValue,
      required this.postFixText,
      required this.prefixText});
}

class QuestionTestScreen extends StatelessWidget {
  List<QuestionModel> questionsList = [
    QuestionModel(
        question: 'Scale body temprature (fever)?',
        max: 42,
        min: 37,
        initValue: 37,
        postFixText: 'High',
        prefixText: 'Normal'),
    //prefix ->normal ---post high
    QuestionModel(
        question: 'Is there any Cough?',
        max: 1,
        min: 0,
        initValue: 0,
        postFixText: 'No',
        prefixText: 'Yes'),
    //display the sumb in center
    QuestionModel(
        question: 'physical fatigue (tiredness)',
        max: 5,
        min: 0,
        initValue: 0,
        postFixText: 'whole body',
        prefixText: 'None Tired'),
    QuestionModel(
        question: 'Loss of Smell and Taste',
        max: 5,
        min: 0,
        initValue: 0,
        postFixText: 'HIGH',
        prefixText: 'LOW'),
    QuestionModel(
        question: 'Difficulity or shortness of breathe',
        max: 5,
        min: 0,
        initValue: 0,
        postFixText: 'Hard',
        prefixText: 'Easy'),
    QuestionModel(
        question: 'aches and pains (headache)',
        max: 5,
        min: 0,
        initValue: 0,
        postFixText: 'Painful',
        prefixText: 'No Pain'),
    QuestionModel(
        question: 'Runny Nose',
        max: 5,
        min: 0,
        initValue: 0,
        postFixText: 'Runny',
        prefixText: 'No'),
    QuestionModel(
        question: 'Chest Pain',
        max: 5,
        min: 0,
        initValue: 0,
        postFixText: 'Painful',
        prefixText: 'No Pain'),
  ];

  PageController questionController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    bool isLastPage = false;
    return BlocConsumer<CoronaCubit, CoronaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        S locale = S.of(context);
        CoronaCubit cubit = CoronaCubit.get(context);
        return Scaffold(
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
                                FloatingActionButton(
                                  heroTag: "btn2",
                                  onPressed: () {
                                    if (isLastPage == true) {
                                      navigateTo(
                                          context: context,
                                          widget: DoneScreen());
                                    } else {
                                      questionController.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeInToLinear);
                                    }
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: isDark ? colorBlack : colorPurple,
                                    ),
                                  ),
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

Widget pageItem(
    {required QuestionModel model,
    required BuildContext context,
    required CoronaCubit cubit}) {
  return Container(
    color: isDark ? colorYellow : colorWhite,
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: SizedBox(),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Container(
              width: double.infinity,
              height: 120,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                child: Center(
                  child: Text(
                    model.question,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
          ),
        ),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: 15,
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
                      valueIndicatorColor: CoronaCubit.sliderValue <= 0
                          ? Color(0xFF1C1C1C)
                          : Colors.red, // This is what you are asking for
                      // inactiveTrackColor:
                      //     Color(0xFF1C1C1C),
                      // // Custom Gray Color
                      // activeTrackColor:
                      //     CoronaCubit.sliderValue <= CoronaCubit.sliderValue / 2
                      //         ? Color(0xFF1C1C1C)
                      //         : Colors.red,
                      thumbColor: CoronaCubit.sliderValue <= 0
                          ? colorBlack
                          : Colors.red,
                      overlayColor: CoronaCubit.sliderValue <= 0
                          ? colorBlack
                          : Colors.red, // Custom Thumb overlay Color
                      // thumbShape:
                      //     RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      // overlayShape:
                      //     RoundSliderOverlayShape(overlayRadius: 15.0),
                    ),
                    child: Slider(
                      value: (model.min + model.max) / 2,
                      // value: CoronaCubit.sliderValue == 0
                      //     ? model.initValue
                      //     : CoronaCubit.sliderValue,
                      onChanged: (newValue) {
                        cubit.onChangeSliderValue(newValue: newValue);
                      },
                      min: model.min,
                      max: model.max,
                      divisions: 100,
                      label: '${CoronaCubit.sliderValue}',
                      activeColor: CoronaCubit.sliderValue <= 0
                          ? Color(0xFF1C1C1C)
                          : Colors.red,
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
