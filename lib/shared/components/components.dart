import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../modules/slide_animation/slide_animation.dart';
import '../cubit/cubit.dart';

Widget defaultTextFormField({
  required TextEditingController? controller,
  TextInputType? keyboardType,
  required String? label,
  required String? Function(String?)? validator,
  IconData? preFixIcon,
  void Function()? onSuffixPressed,
  IconData? suffixIcon,
  bool? obscureText,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    obscureText: obscureText ?? false,
    decoration: InputDecoration(
      prefixIcon: Icon(
        preFixIcon,
        color: colorBlack,
      ),
      labelText: label,
      labelStyle: TextStyle(
        fontSize: 14,
        color: colorBlack,
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
            color: colorBlack,
          ),
          onPressed: onSuffixPressed),
      filled: true,
      fillColor: Color(0xFFECC845),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
    ),
    cursorColor: Color(0xFF1C1C1C),
  );
}

Widget defaultRegisterTextField({
  required TextEditingController? controller,
  required String label,
  TextInputType? keyboardType,
  IconData? prefixIcon,
  IconData? suffixIcon,
  void Function()? onSuffixPressed,
  String? Function(String?)? validator,
  bool? obsecure,
  void Function()? onTap,
  bool? showCursor,
  bool readOnly = false,
}) {
  return TextFormField(
    showCursor: showCursor,
    readOnly: readOnly,
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    onTap: onTap,
    obscureText: obsecure ?? false,
    decoration: InputDecoration(
      prefixIcon: Icon(
        prefixIcon,
        color: Color(0xFF3F3C31),
      ),
      suffixIcon: IconButton(
        icon: Icon(
          suffixIcon,
          color: Color(0xFF3F3C31),
        ),
        onPressed: onSuffixPressed,
      ),
      labelText: label,
      labelStyle: TextStyle(
        fontSize: 12,
        color: Color(0xFF3F3C31),
        fontWeight: FontWeight.bold,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
    ),
    cursorColor: colorBlack,
  );
}

void showToast({required String message, required ToastStatus toastStatus}) {
  Fluttertoast.showToast(
    msg: message.toString(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(toastStatus: toastStatus),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

enum ToastStatus { SUCCESS, FAILD, WARNNING }

Color chooseToastColor({required ToastStatus toastStatus}) {
  Color toastColor;
  switch (toastStatus) {
    case ToastStatus.SUCCESS:
      toastColor = Colors.green;
      break;
    case ToastStatus.FAILD:
      toastColor = Colors.red;
      break;
    case ToastStatus.WARNNING:
      toastColor = Colors.yellow;
      break;
  }
  return toastColor;
}

navigateTo({
  required BuildContext context,
  required widget,
}) {
  Navigator.of(context).push(
    SlideAnimation(widget),
  );
}

navigateAndFinish({required BuildContext context, required Widget widget}) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    return widget;
  }), (route) => false);
}

void pop(BuildContext context) {
  Navigator.pop(context);
}

Widget buildProfileImage({String? image}) {
  return Padding(
    padding: const EdgeInsets.only(right: 12.0),
    child: Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            maxRadius: 25.0,
            backgroundImage: NetworkImage(
              image.toString(),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              CircleAvatar(
                maxRadius: 7.5,
                backgroundColor: isDark ? colorBlack : colorWhite,
              ),
              CircleAvatar(
                maxRadius: 5.7,
                backgroundColor: Color.fromARGB(255, 1, 254, 9),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget getProgressBar({
  bool isDoneScreen = false,
  bool isStartScreen = false,
  bool isQuestionScreen = false,
  bool isGetImageScreen = false,
  bool isTestCompletedScreen = false,
}) {
  return Container(
    height: 60.0,
    padding: EdgeInsets.symmetric(
      horizontal: 20.0,
    ),
    color: Colors.transparent,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              height: 40.0,
              color: colorBlack,
              child: Image.asset(
                'assets/icons/start-button.png',
                color: colorGreen,
              ),
            ),
          ),
          if (isStartScreen == true)
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 1.3,
                ),
                height: 10.0,
                color: colorBlack,
                child: Container(
                  color: colorYellow,
                ),
              ),
            ),
          if (isStartScreen == false)
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 1.3,
              ),
              height: 10.0,
              width: 64.0,
              color: colorBlack,
              child: Row(
                children: [
                  if (CoronaCubit.questionPageIndex >= 0)
                    Container(
                      color: colorGreen,
                      width: 8.0,
                    ),
                  if (CoronaCubit.questionPageIndex >= 1)
                    Container(
                      color: colorGreen,
                      width: 8.0,
                    ),
                  if (CoronaCubit.questionPageIndex >= 2)
                    Container(
                      color: colorGreen,
                      width: 8.0,
                    ),
                  if (CoronaCubit.questionPageIndex >= 3)
                    Container(
                      color: colorGreen,
                      width: 8.0,
                    ),
                  if (CoronaCubit.questionPageIndex >= 4)
                    Container(
                      color: colorGreen,
                      width: 8.0,
                    ),
                  if (CoronaCubit.questionPageIndex >= 5)
                    Container(
                      color: colorGreen,
                      width: 8.0,
                    ),
                  if (CoronaCubit.questionPageIndex >= 6)
                    Container(
                      color: colorGreen,
                      width: 8.0,
                    ),
                  if (CoronaCubit.questionPageIndex >= 7)
                    Container(
                      color: colorGreen,
                      width: 8.0,
                    ),
                ],
              ),
            ),
          CircleAvatar(
            radius: isQuestionScreen ? 20.0 : 22.0,
            backgroundColor:
                isDoneScreen || isGetImageScreen ? colorGreen : colorYellow,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                height: 40.0,
                color: colorBlack,
                child: Image.asset(
                  'assets/icons/test.png',
                  color: isDoneScreen || isGetImageScreen
                      ? colorGreen
                      : colorYellow,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 1.3,
              ),
              height: 10.0,
              color: colorBlack,
              child: Container(
                color: isGetImageScreen ? colorGreen : colorYellow,
              ),
            ),
          ),
          CircleAvatar(
            radius: isQuestionScreen ? 20.0 : 22.0,
            backgroundColor: isTestCompletedScreen ? colorGreen : colorYellow,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                // padding: const EdgeInsets.all(1.0),
                height: 40.0,
                color: colorBlack,
                child: Image.asset(
                  'assets/icons/xray@2x.png',
                  color: isTestCompletedScreen ? colorGreen : colorYellow,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 10.0,
              padding: EdgeInsets.symmetric(
                vertical: 1.3,
              ),
              color: colorBlack,
              child: Container(
                color: isTestCompletedScreen ? colorGreen : colorYellow,
              ),
            ),
          ),
          CircleAvatar(
            radius: isQuestionScreen ? 20.0 : 22.0,
            backgroundColor: isTestCompletedScreen ? colorGreen : colorYellow,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                // padding: const EdgeInsets.all(1.0),
                height: 40.0,
                color: colorBlack,
                child: Image.asset(
                  'assets/icons/work-done.png',
                  color: isTestCompletedScreen ? colorGreen : colorYellow,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  ;
}
