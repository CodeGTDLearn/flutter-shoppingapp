import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

abstract class ICoreAdaptiveModal {
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
  });
}