import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../core/keys/inventory_keys.dart';
import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../../core/texts_icons_provider/pages/inventory/inventory_edit_texts_icons_provided.dart';
import '../../../core/texts_icons_provider/pages/inventory/messages_snackbars_provided.dart';
import '../controller/inventory_controller.dart';
import '../core/custom_form_field/custom_form_field.dart';
import '../core/custom_form_field/field_properties/description_properties.dart';
import '../core/custom_form_field/field_properties/price_properties.dart';
import '../core/custom_form_field/field_properties/title_properties.dart';
import '../core/custom_form_field/field_properties/url_properties.dart';
import '../core/custom_form_field/field_validators/description_validator.dart';
import '../core/custom_form_field/field_validators/price_validator.dart';
import '../core/custom_form_field/field_validators/title_validator.dart';
import '../core/custom_form_field/field_validators/url_validator.dart';
import '../entity/product.dart';

// ignore: must_be_immutable
class InventoryItemDetailsView extends StatelessWidget {
  final String? _id;

  InventoryItemDetailsView([this._id]);

  final _controller = Get.find<InventoryController>();
  final _formKey = K_INV_FORM_GKEY;
  late Product _product;
  var _urlControl;
  var _nodePrice;
  var _nodeDescr;
  var _nodeImgUrl;

  @override
  Widget build(BuildContext context) {
    _startingFormInstances();
    _definingFormTask_updateOrAdd();
    return Scaffold(
        appBar: AppBar(
            title: Text(
                Get.arguments == null ? INV_EDT_LBL_ADD_APPBAR : INV_EDT_LBL_EDIT_APPBAR),
            leading: GestureDetector(onTap: Get.back, child: Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  key: Key(K_INV_ADDEDIT_SAVE_BTN),
                  icon: ICO_INV_EDT_SAVE_BTN_APPBAR,
                  onPressed: () => _saveForm(context))
            ]),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Column(children: [
                  CustomFormField(TitleProperties()).create(
                      product: _product,
                      initialValue: _product.title,
                      context: context,
                      label: INV_EDT_LBL_TITLE,
                      key: K_INV_ADDEDIT_FLD_TITLE,
                      validator: TitleValidator().validate(),
                      onFieldSubmitted: (_) => _setFocus(_nodePrice, context)),
                  CustomFormField(PriceProperties()).create(
                      product: _product,
                      initialValue: _product.price.toString(),
                      context: context,
                      label: INV_EDT_LBL_PRICE,
                      key: K_INV_ADDEDIT_FLD_PRICE,
                      validator: PriceValidator().validate(),
                      onFieldSubmitted: (_) => _setFocus(_nodeDescr, context),
                      node: _nodePrice,
                      controller:
                          _product.price.toString() == '0.0' ? _priceController() : null),
                  CustomFormField(DescriptionProperties()).create(
                      product: _product,
                      initialValue: _product.description,
                      context: context,
                      label: INV_EDT_LBL_DESCR,
                      key: K_INV_ADDEDIT_FLD_DESCR,
                      validator: DescriptionValidator().validate(),
                      onFieldSubmitted: (_) => _setFocus(_nodeImgUrl, context),
                      node: _nodeDescr),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 20, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey)),
                        child: Obx(() => (Container(
                            child: _controller.getImgUrlPreviewObs()
                                ? FittedBox(
                                    child: Image.network(
                                    _urlControl.text,
                                    fit: BoxFit.cover,
                                  ))
                                : Center(child: INV_EDT_NO_IMG_TIT))))),
                    Expanded(
                        child: CustomFormField(UrlProperties()).create(
                            product: _product,
                            initialValue: _product.imageUrl,
                            context: context,
                            label: INV_EDT_LBL_IMGURL,
                            key: K_INV_ADDEDIT_FLD_IMGURL,
                            validator: UrlValidator().validate(),
                            onFieldSubmitted: (_) => _saveForm(context),
                            node: _nodeImgUrl,
                            controller: _urlControl))
                  ])
                ])))));
  }

  void _definingFormTask_updateOrAdd() {
    var findId = Get.parameters['id'] != null || _id != null;
    findId
        ? () {
            _product =
                _controller.getProductById(_id == null ? Get.parameters['id']! : _id!);
            _urlControl.text = _product.imageUrl;
            _controller.setImgUrlPreviewObs(true);
          }.call()
        : () {
            _product = Product.emptyInitialized();
            _nodeImgUrl.addListener(_previewImageUrl);
          }.call();
  }

  void _startingFormInstances() {
    Get.put(TextEditingController(), tag: 'urlControl');
    Get.put(FocusNode(), tag: 'priceNode');
    Get.put(FocusNode(), tag: 'descNode');
    Get.put(FocusNode(), tag: 'urlNode');

    _urlControl = Get.find<TextEditingController>(tag: 'urlControl');
    _nodePrice = Get.find<FocusNode>(tag: 'priceNode');
    _nodeDescr = Get.find<FocusNode>(tag: 'descNode');
    _nodeImgUrl = Get.find<FocusNode>(tag: 'urlNode');
  }

  void _previewImageUrl() {
    var isUnsafeUrl = RegExp(OWASP_SAFE_URL, caseSensitive: false)
            .firstMatch(_urlControl.text.trim()) ==
        null;
    var lostFocus = !_nodeImgUrl.hasFocus;

    if (lostFocus && isUnsafeUrl) return null;
    if (lostFocus) _controller.setImgUrlPreviewObs(true);
  }

  void _saveForm(BuildContext _context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    _product.id == null ? _save(_product, _context) : _update(_product, _context);
    Get.back();
  }

  void _save(Product _product, BuildContext _context) {
    // @formatter:off
    _controller.addProduct(_product).then((product) {
      _controller.updateInventoryProductsObs();
    }).whenComplete(() {
      SimpleSnackbar(SUCES, SUCESS_MAN_PROD_ADD).show();
    }).catchError((onError) {
      Get.defaultDialog(
          title: OPS, middleText: ERROR_MAN_PROD, textConfirm: OK, onConfirm: Get.back);
    });
    // @formatter:on
  }

  //todo: refactoring to the same as the above method
  void _update(Product _product, BuildContext _context) {
    // @formatter:off
    _controller.updateProduct(_product).then((statusCode) {
      if (statusCode >= 200 && statusCode < 400) {
        _controller.updateInventoryProductsObs();
        SimpleSnackbar(SUCES, SUCESS_MAN_PROD_UPDT).show();
      }
      if (statusCode >= 400) {
        Get.defaultDialog(
            title: OPS, middleText: ERROR_MAN_PROD, textConfirm: OK, onConfirm: Get.back);
      }
    });
    // @formatter:on
  }

  void _setFocus(FocusNode node, BuildContext _context) {
    return FocusScope.of(_context).requestFocus(node);
  }

  CurrencyTextFieldController _priceController() {
    return CurrencyTextFieldController(
        rightSymbol: CURRENCY_FORMAT,
        decimalSymbol: DECIMAL_SYMBOL,
        thousandSymbol: THOUSAND_SYMBOL);
  }
}