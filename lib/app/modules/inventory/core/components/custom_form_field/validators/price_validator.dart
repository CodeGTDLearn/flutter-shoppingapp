import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../../core/properties/form_field_sizes.dart';
import '../../../../../../core/properties/owasp_regex.dart';
import '../../../../../../core/texts/core_messages.dart';
import 'icustom_validator.dart';

class PriceValidator extends ICustomValidator {
  final _messages = Get.find<CoreMessages>();

  @override
  FormFieldValidator<String> validator() {
    return Validators.compose([
      Validators.required(_messages.empty_field_msg),
      Validators.minLength(FIELD_PRICE_MIN_SIZE, _messages.format_price_message),
      Validators.patternString(OWASP_SAFE_NUMBER, _messages.format_price_message),
    ]);
  }
}