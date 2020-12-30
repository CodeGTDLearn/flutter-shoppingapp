import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../core/properties/app_owasp_regex.dart';
import '../../../core/messages/field_form_validation_provided.dart';

import 'validation_abstraction.dart';
import 'validation_config.dart';

class ValidateUrl extends ValidationAbstraction {
  @override
  FormFieldValidator<String> validate() {
    return Validators.compose([
      Validators.required(EMPTY_FIELD),
      Validators.patternRegExp(RegExp(SAFE_URL, caseSensitive: false), INVALID_URL_MSG),
      // Validators.patternString(SAFE_URL, INVALID_URL_MSG),
      Validators.minLength(FIELD_URL_MIN_SIZE, INVALID_URL_MSG),
      Validators.maxLength(FIELD_URL_MAX_SIZE, INVALID_URL_MSG),
    ]);
  }
}
