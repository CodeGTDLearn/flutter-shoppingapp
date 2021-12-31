import 'package:flutter/material.dart';

import '../../../../../core/properties/app_form_field_sizes.dart';
import 'properties_abstraction.dart';

class DescriptionProperties extends PropertiesAbstraction {
  @override
  Map<String, dynamic> properties() {
    return {
      'textInputAction': TextInputAction.next,
      'textInputType': TextInputType.multiline,
      'maxLength': FIELD_DESCRIPT_MAX_SIZE,
    };
  }
}