import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../core/properties/app_owasp_regex.dart';
import '../../../core/messages/field_form_validation_provided.dart';
import 'validation_abstraction.dart';
import 'validation_config.dart';

class ValidateTitle extends ValidationAbstraction {
  @override
  FormFieldValidator<String> validate() {
    return Validators.compose([
      Validators.required(EMPTY_FIELD),
      Validators.patternString(SAFE_TEXT, INVALID_TEXT),
      Validators.minLength(FIELD_TITLE_MIN_SIZE, INVALID_TITLE_MSG),
      Validators.maxLength(FIELD_TITLE_MAX_SIZE, INVALID_TITLE_MSG)
    ]);
  }
}
