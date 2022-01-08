import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../core/labels/message_labels.dart';
import '../../../../../core/properties/form_field_sizes.dart';
import '../../../../../core/properties/owasp_regex.dart';
import 'icustom_validator.dart';

class PriceValidator extends ICustomValidator {
  final _messages = Get.find<MessageLabels>();

  @override
  FormFieldValidator<String> validator() {
    return Validators.compose([
      Validators.required(_messages.empty_field_msg()),
      Validators.minLength(FIELD_PRICE_MIN_SIZE, _messages.format_price_message()),
      Validators.patternString(OWASP_SAFE_NUMBER, _messages.format_price_message()),
    ]);
  }
}