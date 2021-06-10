import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../../core/properties/app_owasp_regex.dart';
import '../../../core/messages/field_form_validation_provided.dart';
import 'validator_abstraction.dart';
import '../../../../../core/properties/app_form_field_sizes.dart';

class DescriptionValidator extends ValidatorAbstraction {
  @override
  FormFieldValidator<String> validate() {
    return Validators.compose([
      Validators.required(EMPTY_FIELD_INVALID_MSG),
      Validators.patternString(OWASP_SAFE_TEXT, TEXT_NUMBER_INVALID_MSG),
      Validators.minLength(FIELD_DESC_MIN_SIZE, SIZE_10_INVALID_MSG),
    ]);
  }
}
