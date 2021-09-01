import 'package:flutter/material.dart';

import '../../core/texts_icons/inventory_edit_texts_icons_provided.dart';
import '../../entity/product.dart';
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
      controller: controller ?? null,
      // controller: controller ??
      //     (label == INV_EDT_LBL_PRICE && initialValue.isEmpty
      //         ? _priceController()
      //         : null),
      // 'controller': initialValue.isEmpty ? _priceController : null,
      //***********************************************************************
      decoration: InputDecoration(labelText: label),
      textInputAction: getValue(map, 'textInputAction'),
      maxLength: getValue(map, 'maxLength'),
      maxLines: label == INV_EDT_LBL_DESCR ? 4 : 1,
      keyboardType: getValue(map, 'textInputType'),
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
}
