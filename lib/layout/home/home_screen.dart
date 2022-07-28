import 'package:corona_test_project/generated/l10n.dart';
import 'package:corona_test_project/modules/corona_test_screens/questions_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/modules/start_test/start.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/cubit.dart';
import 'package:corona_test_project/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoronaCubit, CoronaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          drawer: SideBarScreen(),
          appBar: AppBar(
            title: Align(
              alignment: Alignment.center,
              child: Title(
                child: Text(
                  'Home',
                ),
                color: isDark ? colorYellow : colorPurple,
              ),
            ),
            elevation: 20.0,
            actions: [
              buildProfileImage(
                image: CoronaCubit.userModel != null
                    ? CoronaCubit.userModel!.profileImage
                    : 'https://firebasestorage.googleapis.com/v0/b/corona-test-1f5d5.appspot.com/o/default-profile-image.jpg?alt=media&token=0b5b1579-957f-46c4-8a5a-3ce3a34c3945',
              ),
            ],
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(
                  color: isDark ? colorYellow : colorPurple,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 90.0,
                        child: Image.asset(
                          'assets/icons/stethoscope.png',
                          color: isDark ? colorBlack : colorWhite,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Text(
                            S.of(context).DWorry,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: isDark ? colorBlack : colorWhite,
                                      fontSize: 16.0,
                                    ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 30,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                navigateTo(
                                    context: context,
                                    widget: StastTestScreen());
                              },
                              child: Text(
                                S.of(context).test,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: isDark ? colorBlack : colorWhite,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                height: 230,
                decoration: BoxDecoration(
                  color: isDark ? colorYellow : colorPurple,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                'assets/icons/increase.png',
                                height: 75.0,
                                width: 75.0,
                                color: isDark ? colorBlack : colorWhite,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 90.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).incCases,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: isDark
                                                ? colorBlack
                                                : colorWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.fade,
                                          ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '19.000',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 12.0,
                                                color: isDark
                                                    ? colorBlack
                                                    : colorWhite,
                                              ),
                                        ),
                                        Spacer(),
                                        Text(
                                          ' USA',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.red,
                                                fontSize: 16,
                                                overflow: TextOverflow.fade,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 5.0,
                      ),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                'assets/icons/decrease.png',
                                height: 75.0,
                                width: 75.0,
                                color: isDark ? colorBlack : colorWhite,
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 90.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).decCases,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: isDark
                                                ? colorBlack
                                                : colorWhite,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.fade,
                                          ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '5.000',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(
                                                fontSize: 12.0,
                                                color: isDark
                                                    ? colorBlack
                                                    : colorWhite,
                                              ),
                                        ),
                                        Spacer(),
                                        Text(
                                          ' Egypt',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.red,
                                                fontSize: 16,
                                                overflow: TextOverflow.fade,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ],
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
              SizedBox(
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 5.0,
                ),
                decoration: BoxDecoration(
                  color: isDark ? colorYellow : colorPurple,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.asset(
                            'assets/icons/symptom.png',
                            height: 75.0,
                            width: 75.0,
                            color: isDark ? colorBlack : colorWhite,
                          ),
                        ),
                        Text(
                          S.of(context).common,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.red,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        commonSymptomsItem(
                            context: context,
                            iconPath: 'assets/icons/increase.png',
                            text: 'Hard Breathe'),
                        SizedBox(
                          width: 5.0,
                        ),
                        commonSymptomsItem(
                          context: context,
                          iconPath: 'assets/icons/diarrhea.png',
                          text: 'Diarrhea',
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        commonSymptomsItem(
                            context: context,
                            iconPath: 'assets/icons/cough.png',
                            text: 'Coughing'),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        commonSymptomsItem(
                            context: context,
                            iconPath: 'assets/icons/headache@2x.png',
                            text: 'Headache'),
                        SizedBox(
                          width: 5.0,
                        ),
                        commonSymptomsItem(
                            context: context,
                            iconPath: 'assets/icons/cough.png',
                            text: 'Coughing'),
                        SizedBox(
                          width: 5.0,
                        ),
                        commonSymptomsItem(
                            context: context,
                            iconPath: 'assets/icons/increase.png',
                            text: 'Hard Breathe'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 3.0,
                ),
                decoration: BoxDecoration(
                  color: isDark ? colorYellow : colorPurple,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        commonEdge('assets/icons/baby.png'),
                        SizedBox(
                          width: 5.0,
                        ),
                        commonEdge('assets/icons/elderly@2x.png'),
                        SizedBox(
                          width: 5.0,
                        ),
                        commonEdge('assets/icons/young_people.png'),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      S.of(context).mostAges,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isDark ? colorBlack : colorWhite,
                          ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '60+',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.red,
                            fontSize: 22.0,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget commonEdge(String icon) {
  return Expanded(
    child: Container(
      height: 80.0,
      child: Image.asset(
        icon,
        color: isDark ? colorBlack : colorWhite,
      ),
    ),
  );
}

Widget commonSymptomsItem(
    {required BuildContext context,
    required String iconPath,
    required String text}) {
  return Expanded(
    child: Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 75.0,
            width: 90,
            child: Image.asset(
              iconPath,
              color: isDark ? colorBlack : colorWhite,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.red,
                  fontSize: 10.0,
                ),
          ),
        ],
      ),
    ),
  );
}
