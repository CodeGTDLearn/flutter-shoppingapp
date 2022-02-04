import 'package:flutter/material.dart';

import '../../../../../../core/properties/form_field_sizes.dart';
import 'properties_abstraction.dart';

class BarcodeProperties extends PropertiesAbstraction {
  @override
  Map<String, dynamic> properties() {
    return {
      'textInputAction': TextInputAction.next,
      'textInputType': TextInputType.number,
      'maxLength': FIELD_BARCODE_SIZE,
    };
  }
}