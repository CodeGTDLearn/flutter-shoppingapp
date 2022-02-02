import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../../core/properties/form_field_sizes.dart';
import '../../../../../../core/properties/owasp_regex.dart';
import '../../../../../../core/texts/global_messages.dart';
import 'icustom_validator.dart';

class DescriptionValidator extends ICustomValidator {
  final _messages = Get.find<GlobalMessages>();

  @override
  FormFieldValidator<String> validator() {
    return Validators.compose([
      Validators.required(_messages.empty_field_msg),
      Validators.minLength(FIELD_DESC_MIN_SIZE, _messages.size_10_inval_message),
      Validators.patternString(OWASP_SAFE_TEXT, _messages.only_textnumber_message),
    ]);
  }
}