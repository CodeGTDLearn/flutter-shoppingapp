import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../../core/properties/form_field_sizes.dart';
import '../../../../../../core/properties/owasp_regex.dart';
import '../../../../../../core/texts/core_messages.dart';
import 'icustom_validator.dart';

class TitleValidator extends ICustomValidator {
  final _messages = Get.find<CoreMessages>();

  @override
  FormFieldValidator<String> validator() {
    return Validators.compose([
      Validators.required(_messages.empty_field_msg),
      Validators.minLength(FIELD_TITLE_MIN_SIZE, _messages.size_05_inval_message),
      Validators.patternString(OWASP_SAFE_TEXT, _messages.only_textnumber_message),
    ]);
  }
}