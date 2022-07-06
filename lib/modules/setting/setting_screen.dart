import 'package:corona_test_project/generated/l10n.dart';
import 'package:corona_test_project/modules/edit_profile_screen/edit_profile_screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/cubit.dart';
import 'package:corona_test_project/shared/cubit/states.dart';
import 'package:corona_test_project/shared/network/local/cashe_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoronaCubit, CoronaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CoronaCubit cubit = CoronaCubit.get(context);
        List languageList = <String>[
          '${S.of(context).en}',
          '${S.of(context).ar}'
        ];
        return Scaffold(
          drawer: SideBarScreen(),
          appBar: AppBar(
            title: Text(S.of(context).setting),
          ),
          body: CoronaCubit.userModel != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 190,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(backgroundImage),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 50,
                              child: cubit.profileImagefile != null
                                  ? CircleAvatar(
                                      radius: 48,
                                      backgroundImage:
                                          FileImage(cubit.profileImagefile),
                                    )
                                  : CircleAvatar(
                                      radius: 48,
                                      backgroundImage: NetworkImage(
                                          '${CoronaCubit.userModel!.profileImage}'),
                                    ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${CoronaCubit.userModel!.name}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${CoronaCubit.userModel!.email}',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).dark,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Switch(
                                      value: isDark,
                                      onChanged: (isDark) {
                                        CasheHelper.saveData(
                                                key: 'isDark', value: isDark)
                                            .then((value) {
                                          cubit.changeAppMode();
                                        });
                                      },
                                      inactiveThumbColor: Colors.grey,
                                      inactiveTrackColor: Colors.grey,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).language,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 40.0,
                                      width: 120.0,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                        vertical: 3.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Color(0xFFF3D657)
                                            : colorPurple,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: isDark
                                                ? Color(0xFFF3D657)
                                                    .withOpacity(0.1)
                                                : colorBlack.withOpacity(0.2),
                                            spreadRadius: 3.0,
                                            blurRadius: 4,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: DropdownButton(
                                        isExpanded: true,
                                        iconEnabledColor:
                                            isDark ? colorBlack : colorWhite,
                                        focusColor:
                                            isDark ? colorYellow : colorPurple,
                                        underline: SizedBox(),
                                        dropdownColor:
                                            isDark ? colorYellow : colorPurple,
                                        hint: Text(
                                          ReturnTranslatedLanguage(
                                              s: currentLanguage,
                                              context: context),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: isDark
                                                    ? colorBlack
                                                    : colorWhite,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        items: languageList
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem(
                                            child: Text(
                                              value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                    color: isDark
                                                        ? colorBlack
                                                        : colorWhite,
                                                  ),
                                            ),
                                            value: value,
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          cubit.onChangeDropDownButtonValue(
                                              selectLanguage(
                                                  value: newValue ?? '',
                                                  context: context));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark ? Color(0xFFF3D657) : colorPurple,
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isDark
                                    ? Color(0xFFF3D657).withOpacity(0.1)
                                    : colorBlack.withOpacity(0.2),
                                spreadRadius: 3.0,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              navigateTo(
                                  context: context,
                                  widget: EditProfileScreen());
                            },
                            child: Text(
                              S.of(context).editProfile,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                    color:
                                        isDark ? Color(0xFF1C1C1C) : colorWhite,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}

String selectLanguage({required String value, required BuildContext context}) {
  late String language;
  if (value == S.of(context).ar) {
    language = 'ar';
  } else if (value == S.of(context).en) {
    language = 'en';
  }
  return language;
}

String ReturnTranslatedLanguage(
    {required String s, required BuildContext context}) {
  late String language;
  switch (s) {
    case 'en':
      language = S.of(context).en;
      break;
    case 'ar':
      language = S.of(context).ar;
      break;
  }
  return language;
}
