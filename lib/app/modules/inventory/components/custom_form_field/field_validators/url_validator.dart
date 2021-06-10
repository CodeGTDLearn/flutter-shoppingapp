import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../core/properties/app_owasp_regex.dart';
import '../../../core/messages/field_form_validation_provided.dart';

import 'validator_abstraction.dart';
import '../../../../../core/properties/app_form_field_sizes.dart';

class UrlValidator extends ValidatorAbstraction {
  @override
  FormFieldValidator<String> validate() {
    return Validators.compose([
      Validators.required(EMPTY_FIELD_INVALID_MSG),
      Validators.patternRegExp(RegExp(OWASP_SAFE_URL, caseSensitive: false), URL_INVALID_MSG),
      Validators.minLength(FIELD_URL_MIN_SIZE, URL_INVALID_MSG),
      Validators.maxLength(FIELD_URL_MAX_SIZE, URL_INVALID_MSG),
    ]);
  }
}
