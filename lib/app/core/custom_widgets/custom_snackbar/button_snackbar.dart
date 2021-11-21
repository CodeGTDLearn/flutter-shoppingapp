import 'package:flutter/material.dart';

import '../../keys/components/custom_snackbar_keys.dart';
import 'icustom_snackbar.dart';

class ButtonSnackbar implements ICustomSnackbar {
  String title;
  String message;
  String labelButton;
  BuildContext context;
  Function function;

  ButtonSnackbar({
    required this.title,
    required this.message,
    required this.labelButton,
    required this.context,
    required this.function,
  });

  void show() {
    var snackBarButtonConfig = SnackBar(
        duration: Duration(seconds: 1),
        action: SnackBarAction(
            key: Key(K_SNCK), label: labelButton, onPressed: () => function()),
        content: LayoutBuilder(builder: (_, cons) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(children: [
                Container(
                    child: Icon(Icons.thumb_up),
                    width: cons.maxWidth * 0.15,
                    alignment: Alignment.centerLeft),
                Container(
                    width: cons.maxWidth * 0.85,
                    child: Text(message),
                    alignment: Alignment.centerLeft)
              ]));
        }));

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBarButtonConfig);
  }
}