import 'package:flutter/cupertino.dart';

abstract class ICoreAdaptiveModal {
  void create(
    BuildContext context,
    String content,
    String labelYes,
    String labelNo,
    Function actionYes,
    Function actionNo,
  );
}