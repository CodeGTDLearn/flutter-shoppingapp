import 'package:flutter/material.dart';
import 'package:shopingapp/app/pages_modules/managed_products/core/texts_icons/custom_text_form_field_hints.dart';
import 'package:string_validator/string_validator.dart';

import '../../core/messages/field_form_validation_provided.dart';
import '../../core/texts_icons/managed_product_edit_texts_icons_provided.dart';
import '../../entities/product.dart';
import 'validate_description.dart';
import 'validate_price.dart';
import 'validate_title.dart';
import 'validation_abstraction.dart';

class CustomFormField {
  final ValidationAbstraction _title = ValidateTitle();
  final ValidationAbstraction _price = ValidatePrice();
  final ValidationAbstraction _descr = ValidateDescription();

  String _hint;
  String _labelText;
  TextInputAction _textInputAction;
  TextInputType _textInputType;
  String _initialValue;
  int _maxLength;

  // String _keyField;
  var _validatorCriteria;

  TextFormField create(
    Product product,
    BuildContext context,
    Function function,{
    String fieldName,
    FocusNode node,
    TextEditingController controller,
    String key,
  }) {

    _loadTextFieldsParameters(fieldName, product);

    return TextFormField(
      //***************************************************
      //****       !!!!!  INCOMPATIBILITY  !!!!!       ****
      //***************************************************
      //**  CONTROLLER e incompativel com INITIAL_VALUE  **
      //***************************************************
      initialValue: controller == null ? _initialValue : null,
      controller: controller,
      //***************************************************
      key: Key(key),
      decoration: InputDecoration(labelText: _labelText, hintText: _hint),
      textInputAction: _textInputAction,
      maxLength: _maxLength,
      maxLines: fieldName == MAN_PROD_EDIT_FLD_DESCR ? 3 : 1,
      keyboardType: _textInputType,
      // validator: _validatorCriteria,
      // validator: fieldName.toLowerCase() == "url"
      // validator: fieldName == "url"
      validator: fieldName == MAN_PROD_EDIT_FLD_IMG_URL
          ? (value) {
              if (!isURL(value)) return INVALID_URL;
              return null;
            }
          : _validatorCriteria,
      onFieldSubmitted: function,
      onSaved: (fieldValue) =>
          _loadProductWithFieldValue(fieldName, product, fieldValue),
      focusNode: node,
    );
  }

  void _loadTextFieldsParameters(String fieldName, Product product) {

    switch (fieldName) {
      case MAN_PROD_EDIT_FLD_TITLE:
        {
          // _keyField = K_MAN_PROD_FLD_TIT;
          _initialValue = product.title;
          // _hint = TITLE;
          _labelText = fieldName;
          // _labelText = MAN_PROD_EDIT_FLD_TITLE;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.text;
          _maxLength = 15;
          _validatorCriteria = _title.validate();
        }
        break;
      case MAN_PROD_EDIT_FLD_PRICE:
        {
          // _keyField = K_MAN_PROD_FLD_PRICE;
          _initialValue = product.price == null ? "" : product.price.toString();
          // _hint = "AMOUNT";
          _labelText = MAN_PROD_EDIT_FLD_PRICE;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.number;
          _maxLength = 6;
          _validatorCriteria = _price.validate();
        }
        break;
      case MAN_PROD_EDIT_FLD_DESCR:
        {
          // _keyField = K_MAN_PROD_FLD_DESC;
          _initialValue = product.description;
          // _hint = DESCRIPT;
          _labelText = MAN_PROD_EDIT_FLD_DESCR;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.multiline;
          _maxLength = 30;
          _validatorCriteria = _descr.validate();
        }
        break;
      case MAN_PROD_EDIT_FLD_IMG_URL:
        {
          // _keyField = K_MAN_PROD_FLD_URL;
          _initialValue = product.imageUrl;
          // _hint = URL;
          _labelText = MAN_PROD_EDIT_FLD_IMG_URL;
          _textInputAction = TextInputAction.done;
          _textInputType = TextInputType.url;
          _maxLength = 130;
          // _validatorCriteria = _url.validate();
        }
        break;
    }
  }

  void _loadProductWithFieldValue(String fieldName, Product product, var value) {
    if (fieldName == MAN_PROD_EDIT_FLD_TITLE) product.title = value;
    if (fieldName == MAN_PROD_EDIT_FLD_PRICE) product.price = double.parse(value);
    if (fieldName == MAN_PROD_EDIT_FLD_IMG_URL) product.imageUrl = value;
    if (fieldName == MAN_PROD_EDIT_FLD_DESCR) product.description = value;
  }
}
