import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:shopingapp/app/core/platform/cupertino_styles.dart';

import 'i_core_adaptive_modal.dart';

class CoreModalCupertino implements ICoreAdaptiveModal {
  @override
  void create(
    BuildContext context,
    String content,
    String labelYes,
    String labelNo,
    Function actionYes,
    Function actionNo,
  ) {
    var cupertinoAlertDialog = CupertinoAlertDialog(
        title: Text("View: ${Platform.operatingSystem}"),
        content: Text(content,style: CupertinoStyles.modalText),
        actions: [
          CupertinoButton(child: Text(labelYes), onPressed: () => actionYes.call()),
          CupertinoButton(child: Text(labelNo), onPressed: () => actionNo.call()),
        ]);

    showCupertinoDialog(
      context: context,
      builder: (_) => cupertinoAlertDialog,
    );
  }
}