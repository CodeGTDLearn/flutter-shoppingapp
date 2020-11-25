import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/pages_generics_comp_widgets_keys.dart';

class CustomSnackbar {
  static simple({
    String message,
    BuildContext context,
    int duration,
  }) {
    var snackBarSimpleConfig = SnackBar(
        duration: Duration(milliseconds: duration ??= 2000),
        key: Key(CT_SNCK_01),
        content: Text(message));

    Scaffold.of(context).showSnackBar(snackBarSimpleConfig);
  }

  static void button({
    String title,
    message,
    labelButton,
    BuildContext context,
    Function function,
  }) {
    var snackBarButtonConfig = SnackBar(
        duration: Duration(seconds: 2),
        action: SnackBarAction(
            key: Key(CT_SNCK_01),
            label: labelButton,
            onPressed: () => function()),
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

    Scaffold.of(context).showSnackBar(snackBarButtonConfig);
  }
}
