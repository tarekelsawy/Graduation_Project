import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ),
  );
}

navigateAndFinish({required BuildContext context, required Widget widget}) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    return widget;
  }), (route) => false);
}
