import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../../core/properties/app_owasp_regex.dart';
import '../../core/messages/field_form_validation_provided.dart';
import 'validation_abstraction.dart';

class ValidateDescription extends ValidationAbstraction{

  @override
  validate() {
    return Validators.compose([
      Validators.required(EMPTY_FIELD),
      Validators.patternString(SAFE_TEXT, VALID_TEXT),
      Validators.minLength(10, VALID_SIZE_DESCRIPT)
    ]);
  }


}
