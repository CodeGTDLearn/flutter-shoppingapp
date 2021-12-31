import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../core/properties/app_form_field_sizes.dart';
import '../../../../../core/properties/app_owasp_regex.dart';
import '../../../../../core/texts/modules/inventory/field_form_validation_provided.dart';
import 'icustom_validator.dart';

class UrlValidator extends ICustomValidator {
  @override
  FormFieldValidator<String> validator() {
    return Validators.compose([
      Validators.required(EMPTY_FIELD_INVALID_ERROR_MSG),
      Validators.minLength(FIELD_URL_MIN_SIZE, SIZE_URL_INVALID_ERROR_MSG),
      Validators.patternRegExp(
          RegExp(OWASP_SAFE_URL, caseSensitive: false), URL_INVALID_ERROR_MSG),
    ]);
  }
}