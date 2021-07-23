import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../properties/app_properties.dart';
import 'keys/snackbarr_keys.dart';

abstract class Snackbarr {
  void show();
}

class SimpleSnackbar implements Snackbarr {
  String title;
  String message;
  int? durationMilis;

  SimpleSnackbar(this.title, this.message, [this.durationMilis]);

  void show() {
    Get.snackbar(
      title,
      message,
      duration: Duration(milliseconds: durationMilis ??= DURATION),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
  }
}

class ButtonSnackbar implements Snackbarr {
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
