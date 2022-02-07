import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/components/appbar/core_appbar.dart';
import '../../../core/properties/owasp_regex.dart';
import '../../../core/utils/core_animations_utils.dart';
import '../controller/inventory_controller.dart';
import '../core/components/custom_form_field/custom_form_field.dart';
import '../core/components/custom_form_field/field_properties/description_properties.dart';
import '../core/components/custom_form_field/field_properties/price_properties.dart';
import '../core/components/custom_form_field/field_properties/title_properties.dart';
import '../core/components/custom_form_field/field_properties/url_properties.dart';
import '../core/components/custom_form_field/validators/code_field_validator.dart';
import '../core/components/custom_form_field/validators/description_validator.dart';
import '../core/components/custom_form_field/validators/price_validator.dart';
import '../core/components/custom_form_field/validators/title_validator.dart';
import '../core/components/custom_form_field/validators/url_validator.dart';
import '../core/inventory_icons.dart';
import '../core/inventory_keys.dart';
import '../core/inventory_labels.dart';
import '../entity/product.dart';
import 'inventory_product_zoom_view.dart';

// todo: refazer usando o video do rodrigohaman
// https://www.youtube.com/watch?v=GEC4LF40J6k&t=309s
// https://www.youtube.com/watch?v=R8cPBD9eZQY&t=513s
// ignore: must_be_immutable
class InventoryDetailsView extends StatefulWidget {
  final String? _id;

  InventoryDetailsView([this._id]);

  @override
  State<InventoryDetailsView> createState() => _InventoryDetailsViewState();
}

class _InventoryDetailsViewState extends State<InventoryDetailsView> {
  final _labels = Get.find<InventoryLabels>();
  final _appbar = Get.find<CoreAppBar>();
  final _controller = Get.find<InventoryController>();
  final _animations = Get.find<CoreAnimationsUtils>();
  final _icons = Get.find<InventoryIcons>();
  final _keys = Get.find<InventoryKeys>();
  late var _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = _keys.k_inv_form_gkey;
  }

  late Product _product;
  var _urlControl;
  var _nodePrice;
  var _nodeDescr;
  var _nodeImgUrl;
  var _nodeBarcode;
  var _nodeBarcodeButton;

  @override
  Widget build(BuildContext context) {
    _startingFormInstances();
    _definingFormTask_updateOrAdd();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: _appbar.create(
          Get.arguments == null
              ? _labels.inv_edt_lbl_add_appbar
              : _labels.inv_edt_lbl_edit_appbar,
          Get.back,
          actions: [
            IconButton(
                key: Key(_keys.k_inv_edit_save_btn),
                icon: _icons.ico_btn_appbar(),
                onPressed: () => _saveForm(context))
          ]),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    _titleField(context),
                    _priceField(context),
                    _descrField(context),
                    _productImageAndUrlFieldRow(context),
                    SizedBox(height: Get.height * 0.03),
                    _codeFieldRow(context),
                    SizedBox(height: Get.height * 0.06),
                    _stockQtdeAndButtonsRow(context, _product),
                    SizedBox(height: Get.height * 0.02),
                  ])))),
    );
  }

  TextFormField _descrField(BuildContext context) {
    return CustomFormField(DescriptionProperties()).create(
        product: _product,
        initialValue: _product.description,
        context: context,
        label: _labels.inv_edt_lbl_descr,
        key: _keys.k_inv_edit_fld_descr,
        validator: DescriptionValidator().validator(),
        onFieldSubmitted: (_) => _setFocus(_nodeImgUrl, context),
        node: _nodeDescr);
  }

  TextFormField _priceField(BuildContext context) {
    return CustomFormField(PriceProperties()).create(
        product: _product,
        initialValue: _product.price.toString(),
        context: context,
        label: _labels.inv_edt_lbl_price,
        key: _keys.k_inv_edit_fld_price,
        validator: PriceValidator().validator(),
        onFieldSubmitted: (_) => _setFocus(_nodeDescr, context),
        node: _nodePrice,
        controller:
            _product.price.toString() == '0.0' ? _controller.priceController() : null);
  }

  TextFormField _titleField(BuildContext context) {
    return CustomFormField(TitleProperties()).create(
        product: _product,
        initialValue: _product.title,
        context: context,
        label: _labels.inv_edt_lbl_title,
        key: _keys.k_inv_edit_fld_title,
        validator: TitleValidator().validator(),
        onFieldSubmitted: (_) => _setFocus(_nodePrice, context));
  }

  Row _stockQtdeAndButtonsRow(BuildContext context, Product product) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      IconButton(
        icon: Icon(Icons.add_circle_outline),
        onPressed: () => _controller.modalStockQtdeUpdateAddingOrSubtractingItems(context,
            product: product, addition: true),
        focusNode: _nodeBarcodeButton,
        iconSize: 50.00,
        padding: EdgeInsets.only(right: Get.width * 0.05),
      ),
      Container(
          width: Get.width * 0.4,
          child: Obx(
            () => Text(
              _controller.productsStockQtdeObs.value.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                color: Colors.blue,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              )),
            ),
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 3,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 5.0)
              ])),
      IconButton(
        icon: Icon(Icons.remove_circle_outline_outlined),
        onPressed: () => _controller.modalStockQtdeUpdateAddingOrSubtractingItems(context,
            product: product, addition: false),
        focusNode: _nodeBarcodeButton,
        iconSize: 50.00,
        padding: EdgeInsets.only(left: Get.width * 0.05),
      )
    ]);
  }

  Row _codeFieldRow(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: Icon(Icons.qr_code_scanner),
        tooltip: _labels.qrcode_hint,
        onPressed: _controller.scanQRCode,
        focusNode: _nodeBarcodeButton,
      ),
      Expanded(
        child: CustomFormField(DescriptionProperties()).create(
            product: _product,
            initialValue: _product.code,
            context: context,
            label: _labels.inv_edt_lbl_code,
            key: _keys.k_inv_edit_barcode_fld,
            validator: CodeFieldValidator().validator(),
            onFieldSubmitted: (_) => _setFocus(_nodeBarcodeButton, context),
            node: _nodeBarcode),
      ),
      IconButton(
        icon: Icon(Icons.qr_code),
        tooltip: _labels.barcode_hint,
        onPressed: _controller.scanBarCode,
        focusNode: _nodeBarcodeButton,
      )
    ]);
  }

  Row _productImageAndUrlFieldRow(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
          width: 100,
          height: 100,
          margin: EdgeInsets.only(top: 20, right: 10),
          decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey)),
          child: Obx(() => _controller.imgUrlPreviewObs.value
              ? _animations.openContainer(
                  openingWidget:
                      InventoryProductZoomView(_product.title, _product.imageUrl),
                  closingWidget: FittedBox(
                      child: Image.network(_urlControl.text, fit: BoxFit.cover)))
              : Center(child: _icons.ico_edt_no_img()))),
      Expanded(
          child: CustomFormField(UrlProperties()).create(
              product: _product,
              initialValue: _product.imageUrl,
              context: context,
              label: _labels.inv_edt_lbl_imgurl,
              key: _keys.k_inv_edit_fld_imgurl,
              validator: UrlValidator().validator(),
              onFieldSubmitted: (_) => _setFocus(_nodeBarcode, context),
              // onFieldSubmitted: (_) => _saveForm(context),
              node: _nodeImgUrl,
              controller: _urlControl))
    ]);
  }

  void _definingFormTask_updateOrAdd() {
    var findId = Get.parameters['id'] != null || widget._id != null;
    var _productId = widget._id == null ? Get.parameters['id'] : widget._id!;

    findId
        ? () {
            _product = _controller.getProductById(_productId!);
            _controller.imgUrlPreviewObs.value = true;
            _controller.productsStockQtdeObs.value = _product.stockQtde;
          }.call()
        : () {
            _product = Product.emptyInitialized();
            _nodeImgUrl.addListener(_previewProductImage);
            _controller.imgUrlPreviewObs.value = false;
          }.call();

    _urlControl.text = _product.imageUrl;
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

  void _previewProductImage() {
    var isUnsafeUrl = RegExp(OWASP_SAFE_URL, caseSensitive: false)
            .firstMatch(_urlControl.text.trim()) ==
        null;

    var lostFocus = !_nodeImgUrl.hasFocus;
    if (lostFocus && isUnsafeUrl) return null;
    if (lostFocus) _controller.imgUrlPreviewObs.value = true;
  }

  void _saveForm(BuildContext _context) {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    _product.id == null
        ? _controller.saveProductInForm(_product, _context)
        : _controller.updateProductInForm(_product, _context);

    Get.back();
  }

  void _setFocus(FocusNode node, BuildContext _context) {
    return FocusScope.of(_context).requestFocus(node);
  }
}