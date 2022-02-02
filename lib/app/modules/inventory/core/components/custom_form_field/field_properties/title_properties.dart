import 'package:flutter/material.dart';

import '../../../../../../core/properties/form_field_sizes.dart';
import 'properties_abstraction.dart';

class TitleProperties extends PropertiesAbstraction {
  @override
  Map<String, dynamic> properties() {
    return {
      'textInputAction': TextInputAction.next,
      'textInputType': TextInputType.text,
      'maxLength': FIELD_TITLE_MAX_SIZE,
    };
  }
}