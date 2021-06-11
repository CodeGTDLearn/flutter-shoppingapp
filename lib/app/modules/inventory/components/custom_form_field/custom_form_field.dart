import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../core/properties/app_form_field_sizes.dart';
import '../../../../core/properties/app_properties.dart';
import '../../core/texts_icons/inventory_edit_texts_icons_provided.dart';
import '../../entities/product.dart';
import 'field_validators/description_validator.dart';
import 'field_validators/price_validator.dart';
import 'field_validators/title_validator.dart';
import 'field_validators/url_validator.dart';
import 'field_validators/validator_abstraction.dart';

class CustomFormField {
  final ValidatorAbstraction _title = TitleValidator();
  final ValidatorAbstraction _price = PriceValidator();
  final ValidatorAbstraction _descr = DescriptionValidator();
  final ValidatorAbstraction _url = UrlValidator();

  String _hint;
  String _labelText;
  TextInputAction _textInputAction;
  TextInputType _textInputType;
  String _initialValue;
  int _maxLength;
  var _controller;

  var _validatorCriteria;

  TextFormField create({
    Product product,
    BuildContext context,
    Function function,
    String fieldName,
    String key,
    FocusNode node,
    var controller,
  }) {
    _loadTextFieldsParameters(fieldName, product);

    return TextFormField(
      key: Key(key),

      //***  CONTROLLER + INITIAL_VALUE are incompativel   ********************
      initialValue: controller == null ? _initialValue : null,
      // controller: controller == null ? null : controller,
      // todo 01: incompatibilidade entre no controller da url com o controller da
      //  mascara de moeda
      controller: controller ?? product.price == null ? _controller : null,
      //***********************************************************************
      decoration: InputDecoration(labelText: _labelText, hintText: _hint),
      textInputAction: _textInputAction,
      maxLength: _maxLength,
      maxLines: fieldName == INVENT_ADDEDIT_FLD_DESCR ? 3 : 1,
      keyboardType: _textInputType,
      validator: _validatorCriteria,
      onFieldSubmitted: function,
      onSaved: (field) => _loadProductWithFieldValue(fieldName, product, field),
      focusNode: node,
    );
  }

  void _loadTextFieldsParameters(String fieldName, Product product) {
    switch (fieldName) {
      case INVENT_ADDEDIT_FLD_TITLE:
        {
          _labelText = fieldName;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.text;
          _maxLength = FIELD_TITLE_MAX_SIZE;
          _validatorCriteria = _title.validate();
          _initialValue = product.title;
        }
        break;
      case INVENT_ADDEDIT_FLD_PRICE:
        {
          _labelText = fieldName;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.number;
          _maxLength = FIELD_PRICE_MAX_SIZE;
          _validatorCriteria = _price.validate();
          _initialValue = product.price == null ? null : product.price.toString();
          _controller = product.price == null
              ? CurrencyTextFieldController(
                  rightSymbol: CURRENCY_FORMAT,
                  decimalSymbol: DECIMAL_SYMBOL,
                  thousandSymbol: THOUSAND_SYMBOL)
              : null;
        }
        break;
      case INVENT_ADDEDIT_FLD_DESCR:
        {
          _labelText = fieldName;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.multiline;
          _maxLength = FIELD_DESC_MAX_SIZE;
          _validatorCriteria = _descr.validate();
          _initialValue = product.description;
        }
        break;
      case INVENT_ADDEDIT_FLD_IMGURL:
        {
          _labelText = fieldName;
          _textInputAction = TextInputAction.done;
          _textInputType = TextInputType.url;
          _validatorCriteria = _url.validate();
          _maxLength = FIELD_URL_MAX_SIZE;
          _initialValue = product.imageUrl == null ? null : product.imageUrl;
          // _controller = product.imageUrl == null ? controller : null;
        }
        break;
    }
  }

  void _loadProductWithFieldValue(String field, Product product, var value) {
    if (field == INVENT_ADDEDIT_FLD_TITLE) product.title = value;
    if (field == INVENT_ADDEDIT_FLD_IMGURL) product.imageUrl = value;
    if (field == INVENT_ADDEDIT_FLD_DESCR) product.description = value;
    if (field == INVENT_ADDEDIT_FLD_PRICE) {
      var stringValue = value as String;
      stringValue = stringValue.replaceAll(",", "");
      stringValue = stringValue.replaceAll("\$", "");
      product.price = double.parse(stringValue);
    }
  }
}
