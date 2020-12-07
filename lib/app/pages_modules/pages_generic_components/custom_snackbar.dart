import 'package:flutter/material.dart';

import '../../core/properties/app_properties.dart';
import 'core/pages_generics_comp_widgets_keys.dart';

class CustomSnackbar {
}

abstract class CustomAbstractSnackbar {
  // void show();
  Widget show();
}

class SimpleSnackbar implements CustomAbstractSnackbar {
  String message;
  BuildContext context;
  int duration;

  SimpleSnackbar([this.message, this.context, this.duration]);

  // void show() {
  Widget show() {
    var snackBarSimpleConfig = SnackBar(
        duration: Duration(milliseconds: duration ??= DURATION),
        key: Key(CT_SNCK_01),
        content: Text(message));

    Scaffold.of(context).showSnackBar(snackBarSimpleConfig);
  }
}

class SimpleSnackbarBuilder implements CustomAbstractSnackbar {
  String message;
  int duration;

  SimpleSnackbarBuilder([this.message, this.duration]);

  // void show() {
  Widget show() {
     return Builder(builder: (_context) {
      var snackBarSimpleConfig = SnackBar(
          duration: Duration(milliseconds: duration ??= DURATION),
          key: Key(CT_SNCK_01),
          content: Text(message));

      Scaffold.of(_context).showSnackBar(snackBarSimpleConfig);
      return null;
    });

  }
}

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

  // void show() {
  Widget show() {
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
  // static void button({
  //   String title,
  //   message,
  //   labelButton,
  //   BuildContext context,
  //   Function function,
  // }) {
  //   var snackBarButtonConfig = SnackBar(
  //       duration: Duration(seconds: 2),
  //       action: SnackBarAction(
  //           key: Key(CT_SNCK_01),
  //           label: labelButton,
  //           onPressed: () => function()),
  //       content: LayoutBuilder(builder: (_, cons) {
  //         return Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: MediaQuery.of(context).size.height * 0.05,
  //             child: Row(children: [
  //               Container(
  //                   child: Icon(Icons.thumb_up),
  //                   width: cons.maxWidth * 0.15,
  //                   alignment: Alignment.centerLeft),
  //               Container(
  //                   width: cons.maxWidth * 0.85,
  //                   child: Text(message),
  //                   alignment: Alignment.centerLeft)
  //             ]));
  //       }));
  //
  //   Scaffold.of(context).showSnackBar(snackBarButtonConfig);
  // }

// Builder _addOrderButton() {
//   return Builder(builder: (_context) {
//     return FlatButton(
//         child: Text(CRT_LBL_ORD,
//             style: TextStyle(color: Theme.of(_context).primaryColor)),
//         onPressed: () {
//           controller
//               .addOrder(controller.getAllCartItems().values.toList(),
//               controller.amountCartItemsObs.value)
//               .then((_) {
//             controller.clearCart();
//             controller.recalcQtdeAndAmountCart();
//             SimpleSnackbar(SUCES_ORD_ADD, _context).show();
//           })
//               .whenComplete(() =>
//               Future.delayed(Duration(milliseconds: DURATION))
//                   .then((value) => Get.back()))
//               .catchError(
//                   (onError) => SimpleSnackbar(ERROR_ORD, _context).show());
//         });
//   });
// }
