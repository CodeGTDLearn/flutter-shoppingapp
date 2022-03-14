import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'i_core_adaptive_modal.dart';

class CoreModalCupertino implements ICoreAdaptiveModal {
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
    var _contentField = CupertinoTextField(
      autofocus: true,
      controller: contentFieldController,
      textInputAction: TextInputAction.go,
      keyboardType: contentFieldKeyboardType,
      inputFormatters: inputFormatters,
      placeholder: contentFieldPlaceholder,
    );

    var textButtonYes = labelYes == null
        ? null
        : CupertinoButton(onPressed: () => actionYes!.call(), child: Text(labelYes));

    var textButtonNo = labelNo == null
        ? null
        : CupertinoButton(onPressed: () => actionNo!.call(), child: Text(labelNo));

    var cupertinoAlertDialog = CupertinoAlertDialog(
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

    showCupertinoDialog(
      context: context,
      builder: (_) => cupertinoAlertDialog,
    );
  }
}