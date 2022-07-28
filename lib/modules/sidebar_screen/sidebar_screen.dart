import 'package:corona_test_project/generated/l10n.dart';
import 'package:corona_test_project/layout/home/home_screen.dart';
import 'package:corona_test_project/modules/corona_test_screens/questions_screen.dart';
import 'package:corona_test_project/modules/done_folder/done_screen.dart';
import 'package:corona_test_project/modules/edit_profile_screen/edit_profile_screen.dart';
import 'package:corona_test_project/modules/get_image/get_image_screen.dart';
import 'package:corona_test_project/modules/help_screen/help_screen.dart';
import 'package:corona_test_project/modules/register_login/cubit/cubit.dart';
import 'package:corona_test_project/modules/register_login/cubit/states.dart';
import 'package:corona_test_project/modules/setting/setting_screen.dart';

import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/cubit.dart';
import 'package:corona_test_project/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideBarScreen extends StatelessWidget {
  const SideBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoronaCubit, CoronaStates>(
      listener: (context, state) {
        if (state is CoronaSignOutSuccessState) {
          showToast(
              message: 'SignOut Successfuly', toastStatus: ToastStatus.SUCCESS);
        } else if (state is CoronaSignOutErrorState) {
          showToast(message: state.message, toastStatus: ToastStatus.FAILD);
        }
      },
      builder: (context, state) {
        CoronaCubit cubit = CoronaCubit.get(context);
        S locale = S.of(context);
        return Drawer(
          child: ListView(
            children: [
              CoronaCubit.userModel != null
                  ? UserAccountsDrawerHeader(
                      accountName: Text(
                        '${CoronaCubit.userModel!.name}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: colorWhite,
                            ),
                      ),
                      accountEmail: Text(
                        '${CoronaCubit.userModel!.email}',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: Colors.grey[500],
                              fontSize: 12.0,
                            ),
                      ),
                      currentAccountPicture: ClipOval(
                        child: Image.network(
                          '${CoronaCubit.userModel!.profileImage}',
                          fit: BoxFit.cover,
                          width: 90,
                          height: 90,
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/corona-test-1f5d5.appspot.com/o/background-bg3.jpg?alt=media&token=ba808112-5e95-48e4-8288-766f3e95b4ec'),
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: isDark ? colorWhite : colorBlack,
                ),
                onTap: () {
                  navigateTo(context: context, widget: HomeScreen());
                },
                title: Text(locale.homePage,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
              ),
              ListTile(
                leading: Icon(
                  Icons.question_answer,
                  color: isDark ? colorWhite : colorBlack,
                ),
                onTap: () {
                  navigateTo(context: context, widget: QuestionTestScreen());
                },
                title: Text(
                  locale.questions,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.camera_front_rounded,
                  color: isDark ? colorWhite : colorBlack,
                ),
                onTap: () {
                  navigateTo(context: context, widget: GetImageScreen());
                },
                title: Text(
                  locale.imageProcessing,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.done_outline_sharp,
                  color: isDark ? colorWhite : colorBlack,
                ),
                onTap: () {
                  navigateTo(context: context, widget: DoneScreen());
                },
                title: Text(
                  locale.result,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Divider(
                indent: 15,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: isDark ? colorWhite : colorBlack,
                ),
                onTap: () {
                  navigateTo(context: context, widget: SettingScreen());
                },
                title: Text(
                  locale.setting,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.help_outline_rounded,
                  color: isDark ? colorWhite : colorBlack,
                ),
                onTap: () {
                  navigateTo(context: context, widget: HelpScreen());
                },
                title: Text(
                  locale.help,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Divider(
                indent: 15,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: isDark ? colorWhite : colorBlack,
                ),
                onTap: () {
                  cubit.signOut(
                    context: context,
                  );
                },
                title: Text(
                  locale.logout,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
