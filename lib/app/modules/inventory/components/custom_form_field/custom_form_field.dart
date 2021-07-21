import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../core/properties/app_properties.dart';
import '../../core/texts_icons/inventory_edit_texts_icons_provided.dart';
import '../../entities/product.dart';
import 'field_properties/properties_abstraction.dart';

class CustomFormField {
  late final PropertiesAbstraction properties;

  CustomFormField(this.properties);

  TextFormField create({
    required Product product,
    required BuildContext context,
    required Function onFieldSubmitted,
    required String label,
    required String initialValue,
    required String key,
    FormFieldValidator<String>? validator,
    FocusNode? node,
    TextEditingController? controller,
  }) {
    var map = properties.properties();
    return TextFormField(
      key: Key(key),
      //************  CONTROLLER + INITIAL_VALUE are incompativel  ************
      initialValue: controller == null ? initialValue : null,
      controller: controller ??
          (label == INV_EDT_LBL_PRICE && initialValue.isEmpty
              ? _priceController()
              : null),
      // 'controller': initialValue.isEmpty ? _priceController : null,
      //***********************************************************************
      decoration: InputDecoration(labelText: label),
      textInputAction: getValue(map, 'textInputAction'),
      maxLength: getValue(map, 'maxLength'),
      maxLines: label == INV_EDT_LBL_DESCR ? 4 : 1,
      keyboardType: getValue(map, 'textInputType'),
      // validator: getValue(map, 'validatorCriteria'),
      validator: validator,
      onFieldSubmitted: (_) => onFieldSubmitted,
      onSaved: (fieldValue) => _loadProductWithFieldValue(label, product, fieldValue),
      focusNode: node,
    );
  }

  dynamic getValue(Map<String, dynamic> map, String key) {
    return map.forEach((k, v) {
      if (k == key) return v;
    });
  }

  void _loadProductWithFieldValue(String field, Product product, var value) {
    if (field == INV_EDT_LBL_TITLE) product.title = value;
    if (field == INV_EDT_LBL_IMGURL) product.imageUrl = value;
    if (field == INV_EDT_LBL_DESCR) product.description = value;
    if (field == INV_EDT_LBL_PRICE) {
      var txtValue = (value as String).isEmpty ? '0.00' : value.toString();
      txtValue = txtValue.replaceAll(",", "");
      txtValue = txtValue.replaceAll("\$", "");
      product.price = double.parse(txtValue);
    }
  }

  CurrencyTextFieldController _priceController() {
    return CurrencyTextFieldController(
        rightSymbol: CURRENCY_FORMAT,
        decimalSymbol: DECIMAL_SYMBOL,
        thousandSymbol: THOUSAND_SYMBOL);
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

// TextFormField create({
//   required Product product,
//   required BuildContext context,
//   required Function function,
//   required String fieldName,
//   required String key,
//   required FocusNode node,
//   var controller,
// }) {
//   _loadTextFieldsParameters(fieldName, product);
//
//   return TextFormField(
//     key: Key(key),
//
//     //************  CONTROLLER + INITIAL_VALUE are incompativel  ************
//     initialValue: controller == null ? _initialValue : null,
//     controller: controller ?? (fieldName == INV_ADEDT_FLD_PRICE ? _controller : null),
//     //***********************************************************************
//     decoration: InputDecoration(labelText: _labelText, hintText: _hint),
//     textInputAction: _textInputAction,
//     maxLength: _maxLength,
//     maxLines: fieldName == INV_ADEDT_FLD_DESCR ? 4 : 1,
//     keyboardType: _textInputType,
//     validator: _validatorCriteria,
//     onFieldSubmitted: function,
//     onSaved: (field) => _loadProductWithFieldValue(fieldName, product, field),
//     focusNode: node,
//   );
// }

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
