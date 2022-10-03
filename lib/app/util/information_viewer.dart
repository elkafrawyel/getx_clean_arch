import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart' as okToast;

import 'operationReply.dart';

///responsible for showing information to the user it maybe dialogs,snackbars,notification,toast
///this should be the only interface to handle such widgets so that the interface be similar regardless of implementation
abstract class InformationViewer {
  static showToast({
    required String msg,
    double fontSize = 16.0,
    required Color backgroundColor,
    Color? textColor,
  }) {
    okToast.showToast(
      msg,
      textPadding: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
      backgroundColor: backgroundColor,
      position: okToast.ToastPosition.bottom,
      textStyle: TextStyle(fontSize: fontSize, color: textColor),
    );
  }

  static showErrorToast({
    required String msg,
    double fontSize = 16.0,
    Color textColor = Colors.white,
  }) {
    showToast(
      msg: msg,
      backgroundColor: Colors.red,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static showToastBasedOnReply(OperationReply reply) {
    if (reply.isSuccess()) {
      showSuccessToast(msg: reply.message);
    } else if (reply.status == OperationStatus.failed) {
      showErrorToast(msg: reply.message);
    } else {
      showToast(msg: reply.message, backgroundColor: Colors.black);
    }
  }

  static showSuccessToast({
    required String msg,
    double fontSize = 16.0,
    Color textColor = Colors.white,
  }) {
    showToast(
      msg: msg,
      backgroundColor: Colors.green,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static showSnackBar(
    String message, {
    bool popPage = false,
    int duration = 5,
    Color? bgColor,
  }) {
    BuildContext? context = Get.context;

    if (context == null) {
      return;
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor ?? Theme.of(Get.context!).primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 3,
        ),
        duration: Duration(seconds: duration),
      ),
    );
    if (popPage) {
      Timer(
        const Duration(seconds: 5),
        () => Get.back(closeOverlays: true),
      );
    }
  }
}
