import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class CoreAlertDialog {
  static Future<bool?> showOptionDialog(
    BuildContext context,
    String title,
    String content,
    String positiveOption,
    String negativeOption,
    Function onPressedYes,
    Function onPressedNo,
  ) {
    return showDialog<bool>(
        context: context,
        builder: (_) =>
            AlertDialog(title: Text(title), content: Text(content), actions: <Widget>[
              TextButton(
                  child: Text(positiveOption),
                  onPressed: () {
                    onPressedYes();
                    Navigator.of(context).pop(true);
                  }),
              TextButton(
                  child: Text(negativeOption),
                  onPressed: () {
                    onPressedNo();
                    Navigator.of(context).pop(false);
                  })
            ]));
  }
}