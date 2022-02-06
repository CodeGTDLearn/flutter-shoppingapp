import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../core_components_keys.dart';
import 'i_core_snackbar.dart';

class CoreButtonSnackbar implements ICoreSnackbar {
  String labelButton;
  BuildContext context;
  Function function;
  final _keys = Get.find<CoreComponentsKeys>();

  CoreButtonSnackbar({
    required this.labelButton,
    required this.context,
    required this.function,
  });

  void show(String title, String message) {
    var snackBarButtonConfig = SnackBar(
        duration: Duration(seconds: 1),
        action: SnackBarAction(
            key: Key(_keys.k_snackbar_btn()),
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

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBarButtonConfig);
  }
}