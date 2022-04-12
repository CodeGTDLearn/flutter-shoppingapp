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
import '../core/neumorphic_button/neumorphic_button.dart';
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
  final _controller = Get.find<InventoryController>();
  final _animations = Get.find<CoreAnimationsUtils>();
  final _labels = Get.find<InventoryLabels>();
  final _icons = Get.find<InventoryIcons>();
  final _keys = Get.find<InventoryKeys>();
  final _appbar = Get.find<CoreAppBar>();
  late var _formKey;

  late Product _product;
  var _urlControl;
  var _nodePrice;
  var _nodeDescr;
  var _nodeImgUrl;
  var _nodeBarcode;
  var _nodeBarcodeButton;

  @override
  void initState() {
    super.initState();
    _formKey = _keys.k_inv_form_gkey;
    _loadProductVariable();
    _controller.enableDiscountSliderObs.value = false;
    _controller.discountObs.value = _product.discount;
  }

  @override
  Widget build(BuildContext context) {
    _startingFormInstances();
    _definingFormTask_updateOrAdd();
    return Scaffold(
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
                    _barcodeFieldRow(context),
                    SizedBox(height: Get.height * 0.06),
                    _discountSlider(context, _product),
                    SizedBox(height: Get.height * 0.06),
                    _stockQtdeAndNeumorphicButtons(context, _product),
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

  Row _stockQtdeAndNeumorphicButtons(BuildContext context, Product product) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      NeumorphicButton().button(
          milliseconds: 200,
          height: Get.height * 0.1,
          width: Get.width * 0.2,
          downButtonShadowColor: Colors.grey[300]!,
          upButtonShadowColor: Colors.grey[500]!,
          buttonAndBackgroundColor: Colors.white,
          iconSize: 50.00,
          iconButton: Icons.add_circle_outline,
          onTap: () => _controller.modalStockAddOrRemoveItems(context,
              item: product, addition: true)),
      Container(
          width: Get.width * 0.4,
          child: Obx(() {
            return Text(
                _controller.productsStockQtdeObs.value <= 9
                    ? _controller.productsStockQtdeObs.value.toString().padLeft(2, '0')
                    : _controller.productsStockQtdeObs.value.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                  color: Colors.blue,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                )));
          }),
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
      NeumorphicButton().button(
          milliseconds: 200,
          height: Get.height * 0.1,
          width: Get.width * 0.2,
          downButtonShadowColor: Colors.grey[300]!,
          upButtonShadowColor: Colors.grey[500]!,
          buttonAndBackgroundColor: Colors.white,
          iconSize: 50.00,
          iconButton: Icons.remove_circle_outline_outlined,
          onTap: () => _controller.modalStockAddOrRemoveItems(context,
              item: product, addition: false)),
    ]);
  }

  Row _barcodeFieldRow(BuildContext context) {
    return Row(children: [
      IconButton(
          icon: Icon(IconData(0xe900, fontFamily: 'barcode')),
          tooltip: _labels.qrcode_hint,
          onPressed: () => _controller.scanCode(barcode: true, successBeep: true),
          focusNode: _nodeBarcodeButton),
      Obx(() => Expanded(
          child: CustomFormField(DescriptionProperties()).create(
              product: _product,
              initialValue: _product.code,
              context: context,
              // label: _labels.inv_edt_lbl_code,
              label: _controller.productCodeObs.value,
              key: _keys.k_inv_edit_barcode_fld,
              validator: BarcodeFieldValidator().validator(),
              onFieldSubmitted: (_) => _setFocus(_nodeBarcodeButton, context),
              node: _nodeBarcode,
              enable: false))),
      IconButton(
          icon: Icon(Icons.qr_code_scanner_sharp),
          tooltip: _labels.barcode_hint,
          onPressed: () => _controller.scanCode(barcode: false, successBeep: true),
          focusNode: _nodeBarcodeButton)
    ]);
  }

  Container _discountSlider(BuildContext context, Product product) {
    return Container(
        alignment: Alignment.center,
        // height: 100,
        child: Column(children: [
          Obx(() => Text(
              '${_labels.discountLabel}: '
              '${_controller.discountObs.value.toStringAsFixed(0)} %',
              style: GoogleFonts.lato(
                  textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )))),
          Row(children: [
            Flexible(
                flex: 1,
                child: Obx(() => Switch.adaptive(
                    value: _controller.enableDiscountSliderObs.value,
                    onChanged: (enable) {
                      _controller.enableDiscountSlider(enable);
                    }))),
            Flexible(
                flex: 6,
                child: Obx(() => Slider.adaptive(
                    min: 0,
                    max: 100,
                    divisions: 20,
                    value: _controller.discountObs.value,
                    label: '${_controller.discountObs.value.toStringAsFixed(0)}%',
                    onChanged: _controller.enableDiscountSliderObs.value
                        ? (newValue) {
                            _controller.setDiscountSlider(newValue);
                            product.discount = newValue;
                          }
                        : null)))
          ])
        ]));
  }

  Row _productImageAndUrlFieldRow(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
          width: 100,
          height: 100,
          margin: EdgeInsets.only(top: 20, right: 10),
          decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey)),
          child: Obx(() => _controller.productImageUrlPreviewObs.value
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
    var _idFound = Get.parameters['id'] != null || widget._id != null;

    _idFound
        ? () {
            // _product = _controller.getProductById(_productId!);
            _controller.productImageUrlPreviewObs.value = true;
            _controller.productsStockQtdeObs.value = _product.stockQtde;
          }.call()
        : () {
            // _product = Product.emptyInitialized();
            _nodeImgUrl.addListener(_previewProductImage);
            _controller.productImageUrlPreviewObs.value = false;
          }.call();

    _urlControl.text = _product.imageUrl;
  }

  void _loadProductVariable() {
    var _idFound = Get.parameters['id'] != null || widget._id != null;
    var _productId = widget._id ?? Get.parameters['id'];

    _product = _idFound
        ? _product = _controller.getProductById(_productId!)
        : _product = Product.emptyInitialized();
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
    if (lostFocus) _controller.productImageUrlPreviewObs.value = true;
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