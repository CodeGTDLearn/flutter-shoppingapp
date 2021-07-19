import 'package:flutter/material.dart';

import '../../../../../core/properties/app_form_field_sizes.dart';
import '../field_validators/validator_abstraction.dart';
import 'properties_abstraction.dart';

class TitleProperties extends PropertiesAbstraction {
  @override
  Map<String, dynamic> properties(
    String fieldName,
    String initialValue,
    ValidatorAbstraction fieldValidator,
  ) {
    return {
      'labelText': fieldName,
      'textInputAction': TextInputAction.next,
      'textInputType': TextInputType.text,
      'maxLength': FIELD_TITLE_MAX_SIZE,
      'validatorCriteria': fieldValidator,
      'initialValue': initialValue,
    };
  }
}
