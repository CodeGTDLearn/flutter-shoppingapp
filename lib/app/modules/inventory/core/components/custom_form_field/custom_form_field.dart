import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../entity/product.dart';
import '../../inventory_labels.dart';
import 'field_properties/properties_abstraction.dart';

class CustomFormField {
  late final PropertiesAbstraction properties;
  final _labels = Get.find<InventoryLabels>();

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
      maxLines: label == _labels.inv_edt_lbl_descr ? 4 : 1,
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
    if (field == _labels.inv_edt_lbl_title) product.title = value;
    if (field == _labels.inv_edt_lbl_imgurl) product.imageUrl = value;
    if (field == _labels.inv_edt_lbl_descr) product.description = value;
    if (field == _labels.inv_edt_lbl_price) {
      var txtValue = (value as String).isEmpty ? '0.00' : value.toString();
      txtValue = txtValue.replaceAll(",", "");
      txtValue = txtValue.replaceAll("\$", "");
      product.price = double.parse(txtValue);
    }
  }
}