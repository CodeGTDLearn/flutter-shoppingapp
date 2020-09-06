import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../core/properties/app_owasp_regex.dart';
import '../../core/messages/field_form_validation_provided.dart';
import 'validation_abstraction.dart';

class ValidateUrl extends ValidationAbstraction {
  @override
  validate() {
    return Validators.compose([
      Validators.required(EMPTY_FIELD),
      Validators.patternString(SAFE_URL, VALID_URL),
      Validators.minLength(3, VALID_URL),
      Validators.maxLength(135, VALID_URL),
    ]);
  }
}
