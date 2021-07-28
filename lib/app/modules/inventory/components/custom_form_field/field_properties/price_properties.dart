import 'package:flutter/material.dart';

import '../../../../../core/properties/app_form_field_sizes.dart';
import 'properties_abstraction.dart';

class PriceProperties extends PropertiesAbstraction {
  @override
  Map<String, dynamic> properties() {
    // CurrencyTextFieldController _priceController() {
    //   return CurrencyTextFieldController(
    //       rightSymbol: CURRENCY_FORMAT,
    //       decimalSymbol: DECIMAL_SYMBOL,
    //       thousandSymbol: THOUSAND_SYMBOL);
    // }

    return {
      'textInputAction': TextInputAction.next,
      'textInputType': TextInputType.number,
      'maxLength': FIELD_PRICE_MAX_SIZE,
      // 'controller': initialValue.isEmpty ? _priceController : null,
    };
  }
}
