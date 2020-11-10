import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/properties/app_properties.dart';

class CustomSnackbar {
  static simple({String message, BuildContext context}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ));
  }

  static button(
      {String title, message, label, BuildContext context, Function function}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.05,
        child: LayoutBuilder(builder: (_, cons) {
          return Row(
            children: [
              //todo: make adjustments in LayoutBuilder
              Container(
                child: Icon(Icons.thumb_up),
                width: cons.maxWidth * 0.05,
              ),
              Container(
                width: cons.maxWidth * 0.7,
              ),
              Container(
                child: Text(message),
                width: cons.maxWidth * 0.15,
              )
            ],
          );
        }),
      ),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: label,
        onPressed: () {
          function();
        },
      ),
    ));
  }
}
