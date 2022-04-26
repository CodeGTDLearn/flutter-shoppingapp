import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../../core/properties/form_field_properties.dart';
import '../../../../../../core/texts/core_messages.dart';
import 'icustom_validator.dart';

class DateValidator extends ICustomValidator {
  final _messages = Get.find<CoreMessages>();

  @override
  FormFieldValidator<String> validator() {
    return Validators.compose([
      Validators.patternString(FORMAT_DATE, _messages.format_date_message),
    ]);
  }
}