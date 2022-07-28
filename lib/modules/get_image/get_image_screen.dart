import 'package:corona_test_project/generated/l10n.dart';
import 'package:corona_test_project/modules/corona_test_screens/questions_screen.dart';
import 'package:corona_test_project/modules/done_folder/done_screen.dart';
import 'package:corona_test_project/modules/done_folder/final_done_Screen.dart';
import 'package:corona_test_project/modules/sidebar_screen/sidebar_screen.dart';
import 'package:corona_test_project/modules/test_completed/test_completed.dart';
import 'package:corona_test_project/shared/components/components.dart';
import 'package:corona_test_project/shared/components/constants.dart';
import 'package:corona_test_project/shared/cubit/cubit.dart';
import 'package:corona_test_project/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../clip_path/clip_paths.dart';
import 'package:http/http.dart' as http;

class GetImageScreen extends StatelessWidget {
  const GetImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoronaCubit, CoronaStates>(
      listener: (context, state) {
        if (state is CoronaUploadImageToServerSuccessState) {
          showToast(
              message: 'Image Processed Successfully',
              toastStatus: ToastStatus.SUCCESS);
          navigateTo(context: context, widget: TestCompletedScreen());
        }
      },
      builder: (context, state) {
        CoronaCubit cubit = CoronaCubit.get(context);
        return Scaffold(
          drawer: SideBarScreen(),
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: isDark ? colorYellow : colorWhite,
                ),
                Column(
                  children: [
                    getProgressBar(
                      isGetImageScreen: true,
                    ),
                    Expanded(
                      child: Container(
                        color: isDark ? colorYellow : colorWhite,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 5.0,
                                  ),
                                  child: Container(
                                    child: Center(
                                      child: CoronaCubit.imageFile != null
                                          ? Image.file(
                                              CoronaCubit.imageFile,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.72,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.photo,
                                                  color: isDark
                                                      ? Color.fromARGB(
                                                          255, 230, 215, 151)
                                                      : colorWhite
                                                          .withOpacity(0.7),
                                                  size: 100,
                                                ),
                                                Text(
                                                  S.of(context).imagePreview,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1!
                                                      .copyWith(
                                                          color: isDark
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  230,
                                                                  215,
                                                                  151)
                                                              : colorWhite
                                                                  .withOpacity(
                                                                      0.7),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark ? colorBlack : colorPurple,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  buttonInImageScreen(
                                    context: context,
                                    text: S.of(context).gallary,
                                    icon: Icons.photo_library_outlined,
                                    onPressed: () => cubit.getImage(
                                      source: ImageSource.gallery,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  buttonInImageScreen(
                                    context: context,
                                    text: S.of(context).camera,
                                    icon: Icons.photo_camera_outlined,
                                    onPressed: () => cubit.getImage(
                                      source: ImageSource.camera,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
                                  heroTag: 'hero1',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: isDark ? colorBlack : colorPurple,
                                      size: 35.0,
                                    ),
                                  ),
                                  backgroundColor:
                                      isDark ? colorYellow : colorWhite,
                                ),
                                const SizedBox(
                                  width: 60,
                                ),
                                state is! CoronaUploadImageToServerLoadingState
                                    ? FloatingActionButton(
                                        heroTag: 'hero2',
                                        onPressed: CoronaCubit.imageFile != null
                                            ? () {
                                                cubit.uploadImage(
                                                    imageFile:
                                                        CoronaCubit.imageFile);
                                              }
                                            : null,
                                        child: Center(
                                          child: Icon(
                                            Icons.done,
                                            color: isDark
                                                ? colorBlack
                                                : colorPurple,
                                            size: 35.0,
                                          ),
                                        ),
                                        backgroundColor: isDark
                                            ? CoronaCubit.imageFile != null
                                                ? colorYellow
                                                : Color.fromARGB(
                                                    255, 100, 93, 61)
                                            : CoronaCubit.imageFile != null
                                                ? colorWhite
                                                : colorWhite.withOpacity(0.5),
                                      )
                                    : Center(
                                        child: CircularProgressIndicator()),
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

Widget buttonInImageScreen(
    {required String text,
    required IconData icon,
    required void Function()? onPressed,
    required BuildContext context}) {
  return Row(
    children: [
      const Expanded(
        flex: 1,
        child: SizedBox(),
      ),
      Expanded(
        flex: 8,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? colorBlack : colorPurple,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Color.fromARGB(255, 117, 105, 51)
                    : colorBlack.withOpacity(0.2),
                spreadRadius: 1.0,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: TextButton.icon(
            onPressed: onPressed,
            label: Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: isDark ? colorYellow : colorWhite,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            icon: Icon(
              icon,
              color: isDark ? colorYellow : colorWhite,
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: SizedBox(),
      ),
    ],
  );
}
