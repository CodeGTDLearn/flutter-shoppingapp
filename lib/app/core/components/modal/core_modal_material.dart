import 'dart:io';

import 'package:flutter/material.dart';

import 'i_core_adaptive_modal.dart';

class CoreModalMaterial implements ICoreAdaptiveModal {
  @override
  void create(
    BuildContext context,
    String content,
    String labelYes,
    String labelNo,
    Function actionYes,
    Function actionNo,
  ) {
    var alertDialog = AlertDialog(
      title: Text("View: ${Platform.operatingSystem}"),
      content: Text(content),
      actions: [
        TextButton(onPressed: () => actionYes.call(), child: Text(labelYes)),
        TextButton(onPressed: () => actionNo.call(), child: Text(labelNo)),
      ],
    );

    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}