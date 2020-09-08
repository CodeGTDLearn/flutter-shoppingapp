import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../core/properties/app_owasp_regex.dart';
import '../../core/messages/field_form_validation_provided.dart';
import 'validation_abstraction.dart';

class ValidateUrl extends ValidationAbstraction {
  @override
  validate() {
    return  Validators.compose([
      Validators.required(EMPTY_FIELD),
      Validators.patternString(SAFE_URL, INVALID_URL),
      Validators.minLength(3, INVALID_URL),
      Validators.maxLength(135, INVALID_URL),
    ]);
  }
}

