import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../core/properties/app_owasp_regex.dart';
import '../../../core/messages/field_form_validation_provided.dart';
import 'validation_abstraction.dart';
import 'validation_config.dart';

class ValidateDescription extends ValidationAbstraction {
  @override
  FormFieldValidator<String> validate() {
    return Validators.compose([
      Validators.required(EMPTY_FIELD),
      Validators.patternString(SAFE_TEXT, INVALID_TEXT_MSG),
      Validators.minLength(FIELD_DESC_MIN_SIZE, INVALID_DESCR_MSG),
      Validators.maxLength(FIELD_DESC_MAX_SIZE, INVALID_DESCR_MSG),
    ]);
  }
}
