import 'package:flutter/material.dart';

import '../../../../../../core/properties/form_field_properties.dart';
import 'properties_abstraction.dart';

class UrlProperties extends PropertiesAbstraction {
  @override
  Map<String, dynamic> properties() {
    return {
      'textInputAction': TextInputAction.done,
      'textInputType': TextInputType.url,
      'maxLength': FIELD_URL_MAX_SIZE,
    };
  }
}