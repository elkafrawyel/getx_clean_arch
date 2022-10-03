import 'package:flutter/material.dart';

Future<void> showAppDialog(
    BuildContext context,
    //preferred as Column
    Widget child, {
      double? height,
      Color? backgroundColor,
      double horizontalPadding = 12.0,
      double radius = 12.0,
      bool barrierDismissible = false,
      EdgeInsets contentPadding = const EdgeInsets.all(12.0),
    }) async {
  await showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) => AlertDialog(
      backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 0.0),
      contentPadding: contentPadding,
      content: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          height: height,
          width: MediaQuery.of(context).size.width,
          child: child,
        ),
      ),
    ),
  );
}

void scaleDialog(
  BuildContext context, {
  required String title,
  required String content,
  String? confirmText,
  String? cancelText,
  VoidCallback? onConfirmClick,
  VoidCallback? onCancelClick,
  bool barrierDismissible = false,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'dialog',
    pageBuilder: (ctx, a1, a2) {
      return Container();
    },
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: AlertDialog(
          title: Text(title, style: Theme.of(context).textTheme.bodyText1),
          content: Text(content, style: Theme.of(context).textTheme.caption),
          actions: <Widget>[
            if (onConfirmClick != null)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(confirmText ?? "Confirm"),
              ),
            if (onCancelClick != null)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(cancelText ?? "Cancel"),
              )
          ],
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 300),
  );
}
