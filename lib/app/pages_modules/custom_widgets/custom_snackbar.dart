import 'package:flutter/material.dart';

import 'core/keys/custom_snackbar_widgets_keys.dart';

// import '../../core/properties/app_properties.dart';
// import 'core/keys/custom_snackbar_widgets_keys.dart';
//
// class CustomSnackbar {}

abstract class CustomAbstractSnackbar {
  Widget show();
}

//
// class SimpleSnackbar implements CustomAbstractSnackbar {
//   String message;
//   BuildContext context;
//   int duration;
//
//   SimpleSnackbar([this.message, this.context, this.duration]);
//
//   Widget show() {
//     var snackBarConfig = SnackBar(
//         duration: Duration(milliseconds: duration ??= DURATION),
//         key: Key(K_SNCK),
//         content: Text(message));
//
//     Scaffold.of(context).removeCurrentSnackBar();
//     Scaffold.of(context).showSnackBar(snackBarConfig);
//   }
// }
//
// class SimpleSnackbarBuilder implements CustomAbstractSnackbar {
//   String message;
//   int duration;
//
//   SimpleSnackbarBuilder([this.message, this.duration]);
//
//   Widget show() {
//     return Builder(builder: (_context) {
//       var snackBarConfig = SnackBar(
//           duration: Duration(milliseconds: duration ??= DURATION),
//           key: Key(K_SNCK),
//           content: Text(message));
//
//       Scaffold.of(_context).removeCurrentSnackBar();
//       Scaffold.of(_context).showSnackBar(snackBarConfig);
//       return snackBarConfig;
//     });
//   }
// }
//
class ButtonSnackbar implements CustomAbstractSnackbar {
  String title;
  String message;
  String labelButton;
  BuildContext context;
  Function function;

  ButtonSnackbar(
      {this.title,
      this.message,
      this.labelButton,
      this.context,
      this.function});

  Widget show() {
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

    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snackBarButtonConfig);
  }
}
