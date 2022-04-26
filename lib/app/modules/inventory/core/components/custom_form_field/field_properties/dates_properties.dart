import 'package:flutter/material.dart';

import 'properties_abstraction.dart';

class DateProperties extends PropertiesAbstraction {
  @override
  Map<String, dynamic> properties() {
    return {
      'textInputAction': TextInputAction.done,
      'textInputType': TextInputType.datetime,
      // 'maxLength': FIELD_PRICE_MAX_SIZE,
    };
  }
}