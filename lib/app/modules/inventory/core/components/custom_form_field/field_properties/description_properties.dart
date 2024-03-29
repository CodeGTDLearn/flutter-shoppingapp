import 'package:flutter/material.dart';

import '../../../../../../core/properties/form_field_properties.dart';
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