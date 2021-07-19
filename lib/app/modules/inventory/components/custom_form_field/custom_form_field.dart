import 'package:flutter/material.dart';

import '../../core/texts_icons/inventory_edit_texts_icons_provided.dart';
import '../../entities/product.dart';
import 'field_properties/properties_abstraction.dart';
import 'field_validators/validator_abstraction.dart';

class CustomFormField {
  late final ValidatorAbstraction validator;
  late final PropertiesAbstraction properties;

  CustomFormField(this.validator, this.properties);

  TextFormField create({
    required Product product,
    required BuildContext context,
    required Function function,
    required String fieldName,
    required String initialValue,
    required String key,
    FocusNode? node,
    var controller,
  }) {
    var map = properties.properties(fieldName, initialValue, validator);
    return TextFormField(
      key: Key(key),
      //************  CONTROLLER + INITIAL_VALUE are incompativel  ************
      initialValue: controller == null ? getValue(map, 'initialValue') : null,
      controller: controller ??
          (fieldName == INV_ADEDT_FLD_PRICE ? getValue(map, 'controller') : null),
      //***********************************************************************
      decoration: InputDecoration(labelText: getValue(map, 'labelText')),
      textInputAction: getValue(map, 'textInputAction'),
      maxLength: getValue(map, 'maxLength'),
      maxLines: fieldName == INV_ADEDT_FLD_DESCR ? 4 : 1,
      keyboardType: getValue(map, 'textInputType'),
      validator: getValue(map, 'validatorCriteria'),
      onFieldSubmitted: function(),
      onSaved: (fieldValue) => _loadProductWithFieldValue(fieldName, product, fieldValue),
      focusNode: node,
    );
    // validator: _validatorCriteria,
  }

  dynamic getValue(Map<String, dynamic> map, String key) {
    return map.forEach((k, v) {
      if (k == key) return v;
    });
  }

  void _loadProductWithFieldValue(String field, Product product, var value) {
    if (field == INV_ADEDT_FLD_TITLE) product.title = value;
    if (field == INV_ADEDT_FLD_IMGURL) product.imageUrl = value;
    if (field == INV_ADEDT_FLD_DESCR) product.description = value;
    if (field == INV_ADEDT_FLD_PRICE) {
      var stringValue = value as String;
      stringValue = stringValue.replaceAll(",", "");
      stringValue = stringValue.replaceAll("\$", "");
      product.price = double.parse(stringValue);
    }
  }
}
// final ValidatorAbstraction _validTitle = TitleValidator();
// final ValidatorAbstraction _validPrice = PriceValidator();
// final ValidatorAbstraction _validDescr = DescriptionValidator();
// final ValidatorAbstraction _validUrl = UrlValidator();
//
// final PropertiesAbstraction _propsTitle = TitleProperties();
// final PropertiesAbstraction _propsPrice = PriceProperties();
// final PropertiesAbstraction _propsDescr = DescriptionProperties();
// final PropertiesAbstraction _propsUrl = UrlProperties();

// late String _hint;
// late String _labelText;
// late TextInputAction _textInputAction;
// late TextInputType _textInputType;
// late String _initialValue;
// late int _maxLength;
// late var _controller;

// var _validatorCriteria;
// void _loadTextFieldParameters(String fieldName, Product fieldContent) {
//   switch (fieldName) {
//     case INV_ADEDT_FLD_TITLE:
//       {
//         _labelText = fieldName;
//         _textInputAction = TextInputAction.next;
//         _textInputType = TextInputType.text;
//         _maxLength = FIELD_TITLE_MAX_SIZE;
//         _validatorCriteria = _validTitle.validate();
//         _initialValue = fieldContent.title;
//       }
//       break;
//     case INV_ADEDT_FLD_PRICE:
//       {
//         _labelText = fieldName;
//         _textInputAction = TextInputAction.next;
//         _textInputType = TextInputType.number;
//         _maxLength = FIELD_PRICE_MAX_SIZE;
//         _validatorCriteria = _validPrice.validate();
//         _initialValue = fieldContent.price.toString();
//         _controller = fieldContent.price == null ? _priceController() : null;
//       }
//       break;
//     case INV_ADEDT_FLD_DESCR:
//       {
//         _labelText = fieldName;
//         _textInputAction = TextInputAction.next;
//         _textInputType = TextInputType.multiline;
//         _maxLength = FIELD_DESCRIPT_MAX_SIZE;
//         _validatorCriteria = _validDescr.validate();
//         _initialValue = fieldContent.description;
//       }
//       break;
//     case INV_ADEDT_FLD_IMGURL:
//       {
//         _labelText = fieldName;
//         _textInputAction = TextInputAction.done;
//         _textInputType = TextInputType.url;
//         _validatorCriteria = _validUrl.validate();
//         _maxLength = FIELD_URL_MAX_SIZE;
//         _initialValue = fieldContent.imageUrl;
//       }
//       break;
//   }
// }
// CurrencyTextFieldController _priceController() {
//   return CurrencyTextFieldController(
//       rightSymbol: CURRENCY_FORMAT,
//       decimalSymbol: DECIMAL_SYMBOL,
//       thousandSymbol: THOUSAND_SYMBOL);
// }
