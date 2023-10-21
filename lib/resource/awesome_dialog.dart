import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart'; // Assuming AwesomeDialog is in this package

class GetAwesomeDialog {
  static void showCustomDialog({
    required BuildContext context,
    required DialogType dialogType,
    required String title,
    required String desc,
    bool isTouch = true,
    required Function() btnOkPress,
    required Function()? btnCancelPress,
  }) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: dialogType,
      title: title,
      // useRootNavigator: isTouch,
      dismissOnTouchOutside: isTouch,
      titleTextStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      desc: desc,
      btnOkOnPress: btnOkPress,
      btnCancelOnPress: btnCancelPress ?? () => Navigator.pop(context),
    ).show();
  }
}
