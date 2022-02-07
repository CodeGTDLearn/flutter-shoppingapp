import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'i_core_adaptive_modal.dart';

class CoreModalMaterial implements ICoreAdaptiveModal {
  @override
  void create(
    BuildContext context, {
    String? title,
    String? content,
    required bool contentField,
    TextInputType? contentFieldKeyboardType,
    String? contentFieldPlaceholder,
    TextEditingController? contentFieldController,
    List<TextInputFormatter>? inputFormatters,
    String? labelYes,
    String? labelNo,
    Function? actionYes,
    Function? actionNo,
  }) {
    var _contentField = TextField(
      autofocus: true,
      controller: contentFieldController,
      textInputAction: TextInputAction.done,
      keyboardType: contentFieldKeyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(hintText: contentFieldPlaceholder),
    );

    var textButtonYes = labelYes == null
        ? null
        : TextButton(onPressed: () => actionYes!.call(), child: Text(labelYes));

    var textButtonNo = labelNo == null
        ? null
        : TextButton(onPressed: () => actionNo!.call(), child: Text(labelNo));

    var alertDialog = AlertDialog(
      title: title == null ? null : Text(title),
      content: contentField
          ? _contentField
          : content == null
              ? null
              : Text(content),
      actions: [
        textButtonYes!,
        textButtonNo!,
      ],
    );

    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}