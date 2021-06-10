import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../core/properties/app_form_field_sizes.dart';
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
      //******************************************************
      //****        !!!!!  INCOMPATIBILITY  !!!!!         ****
      //******************************************************
      //***  CONTROLLER e incompativel com INITIAL_VALUE   ***
      initialValue: controller == null ? _initialValue : null,
      controller: controller,
      //******************************************************
      decoration: InputDecoration(labelText: _labelText, hintText: _hint),
      textInputAction: _textInputAction,
      maxLength: _maxLength,
      maxLines: fieldName == INV_ADDEDIT_FLD_DESCR ? 3 : 1,
      keyboardType: _textInputType,
      validator: _validatorCriteria,
      onFieldSubmitted: function,
      onSaved: (field) => _loadProductWithFieldValue(fieldName, product, field),
      focusNode: node,
    );
  }

  void _loadTextFieldsParameters(String fieldName, Product product) {
    switch (fieldName) {
      case INV_ADDEDIT_FLD_TITLE:
        {
          _initialValue = product.title;
          _labelText = fieldName;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.text;
          _maxLength = FIELD_TITLE_MAX_SIZE;
          _validatorCriteria = _title.validate();
        }
        break;
      case INV_ADDEDIT_FLD_PRICE:
        {
          _initialValue = product.price == null ? "" : product.price.toString();
          _labelText = fieldName;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.number;
          _maxLength = FIELD_PRICE_MAX_SIZE;
          _validatorCriteria = _price.validate();
        }
        break;
      case INV_ADDEDIT_FLD_DESCR:
        {
          _initialValue = product.description;
          _labelText = fieldName;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.multiline;
          _maxLength = FIELD_DESC_MAX_SIZE;
          _validatorCriteria = _descr.validate();
        }
        break;
      case INV_ADDEDIT_FLD_IMG_URL:
        {
          _initialValue = product.imageUrl;
          _labelText = fieldName;
          _textInputAction = TextInputAction.done;
          _textInputType = TextInputType.url;
          _validatorCriteria = _url.validate();
          _maxLength = FIELD_URL_MAX_SIZE;
        }
        break;
    }
  }

  void _loadProductWithFieldValue(String field, Product product, var value) {
    if (field == INV_ADDEDIT_FLD_TITLE) product.title = value;
    if (field == INV_ADDEDIT_FLD_IMG_URL) product.imageUrl = value;
    if (field == INV_ADDEDIT_FLD_DESCR) product.description = value;
    if (field == INV_ADDEDIT_FLD_PRICE) {
      var stringValue = value as String;
      stringValue = stringValue.replaceAll(",","");
      stringValue = stringValue.replaceAll("\$","");
      product.price = double.parse(stringValue);
      //TODO 01: quando a edicao e carregada, o preco aparece vazio
    }
  }
}
