import 'package:flutter/material.dart';
import 'package:shopingapp/app/pages_modules/managed_products/core/messages/field_form_validation_provided.dart';
import 'package:string_validator/string_validator.dart';

import '../../core/texts_icons/custom_text_form_field_hints.dart';
import '../../core/texts_icons/managed_product_edit_texts_icons_provided.dart';
import '../../entities/product.dart';
import 'validate_description.dart';
import 'validate_price.dart';
import 'validate_title.dart';
import 'validate_url.dart';
import 'validation_abstraction.dart';

class CustomFormTextField {
  final ValidationAbstraction _title = ValidateTitle();
  final ValidationAbstraction _price = ValidatePrice();
  final ValidationAbstraction _descr = ValidateDescription();
  final ValidationAbstraction _url = ValidateUrl();

  String _hint;
  String _labelText;
  TextInputAction _textInputAction;
  TextInputType _textInputType;
  String _initialValue;
  int _maxLength;
  var _validatorCriteria;

  TextFormField create(
    Product product,
    BuildContext context,
    Function function,
    String fieldName, [
    FocusNode node,
    TextEditingController controller,
  ]) {
    loadTextFieldsParameteres(fieldName, product);

    return TextFormField(
      initialValue: _initialValue,
      decoration: InputDecoration(labelText: _labelText, hintText: _hint),
      textInputAction: _textInputAction,
      maxLength: _maxLength,
      maxLines: fieldName == "description" ? 3 : 1,
      keyboardType: _textInputType,
      validator: _validatorCriteria,
      onFieldSubmitted: function,
      onSaved: (fieldValue) =>
          _loadProductWithFieldValue(fieldName, product, fieldValue),
      focusNode: node,
      controller: controller,
    );
  }

  void loadTextFieldsParameteres(String nameField, Product product) {
    switch (nameField.toLowerCase()) {
      case "title":
        {
          _initialValue = product.title;
          _hint = TITLE;
          _labelText = MAN_PROD_EDIT_FLD_TITLE;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.text;
          _maxLength = 15;
          _validatorCriteria = _title.validate();
        }
        break;
      case "price":
        {
          _initialValue = product.price.toString();
          _hint = AMOUNT;
          _labelText = MAN_PROD_EDIT_FLD_PRICE;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.number;
          _maxLength = 6;
          _validatorCriteria = _price.validate();
        }
        break;
      case "description":
        {
          _initialValue = product.description;
          _hint = DESCRIPT;
          _labelText = MAN_PROD_EDIT_FLD_DESCR;
          _textInputAction = TextInputAction.next;
          _textInputType = TextInputType.multiline;
          _maxLength = 30;
          _validatorCriteria = _descr.validate();
        }
        break;
      case "url":
        {
          _initialValue = product.imageUrl;
          _hint = URL;
          _labelText = MAN_PROD_EDIT_FLD_IMG_URL;
          _textInputAction = TextInputAction.done;
          _textInputType = TextInputType.url;
          _maxLength = 130;
          _validatorCriteria = _url.validate();
        }
        break;
    }
  }

  void _loadProductWithFieldValue(String field, Product product, var value) {
    if (field.toLowerCase() == "title") product.title = value;
    if (field.toLowerCase() == "url") product.imageUrl = value;
    if (field.toLowerCase() == "description") product.description = value;
    if (field.toLowerCase() == "price") product.price = double.parse(value);
  }
}
      // validator: fieldName == "description"
      //     ? (value) {
      //         if (!isURL(value)) return VALID_URL;
      //         return null;
      //       }
      //     : _validatorCriteria,
