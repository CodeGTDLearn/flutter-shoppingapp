import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/appbar/custom_appbar.dart';
import '../../../core/custom_widgets/snackbar/simple_snackbar.dart';
import '../../../core/icons/modules/inventory/inventory_details_icons.dart';
import '../../../core/keys/modules/inventory_keys.dart';
import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts/general_words.dart';
import '../../../core/texts/messages.dart';
import '../../../core/texts/modules/inventory_labels.dart';
import '../../../core/utils/animations_utils.dart';
import '../components/custom_form_field/custom_form_field.dart';
import '../components/custom_form_field/field_properties/description_properties.dart';
import '../components/custom_form_field/field_properties/price_properties.dart';
import '../components/custom_form_field/field_properties/title_properties.dart';
import '../components/custom_form_field/field_properties/url_properties.dart';
import '../components/custom_form_field/validators/description_validator.dart';
import '../components/custom_form_field/validators/price_validator.dart';
import '../components/custom_form_field/validators/title_validator.dart';
import '../components/custom_form_field/validators/url_validator.dart';
import '../controller/inventory_controller.dart';
import '../entity/product.dart';
import 'inventory_image_view.dart';

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
  final _words = Get.find<GeneralWords>();
  final _labels = Get.find<InventoryLabels>();
  final _appbar = Get.find<CustomAppBar>();
  final _controller = Get.find<InventoryController>();
  final _animations = Get.find<AnimationsUtils>();
  final _icons = Get.find<InventoryDetailsIcons>();
  final _messages = Get.find<Messages>();

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
        appBar: _appbar.create(
            Get.arguments == null ? _labels.INV_EDT_LBL_ADD_APPBAR() :
            _labels.INV_EDT_LBL_EDIT_APPBAR(),
            Get.back,
            actions: [
              IconButton(
                  key: Key(K_INV_ADDEDIT_SAVE_BTN),
                  icon: _icons.ico_btn_appbar(),
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
                      label: _labels.INV_EDT_LBL_TITLE(),
                      key: K_INV_ADDEDIT_FLD_TITLE,
                      validator: TitleValidator().validator(),
                      onFieldSubmitted: (_) => _setFocus(_nodePrice, context)),
                  CustomFormField(PriceProperties()).create(
                      product: _product,
                      initialValue: _product.price.toString(),
                      context: context,
                      label: _labels.INV_EDT_LBL_PRICE(),
                      key: K_INV_ADDEDIT_FLD_PRICE,
                      validator: PriceValidator().validator(),
                      onFieldSubmitted: (_) => _setFocus(_nodeDescr, context),
                      node: _nodePrice,
                      controller:
                          _product.price.toString() == '0.0' ? _priceController() : null),
                  CustomFormField(DescriptionProperties()).create(
                      product: _product,
                      initialValue: _product.description,
                      context: context,
                      label: _labels.INV_EDT_LBL_DESCR(),
                      key: K_INV_ADDEDIT_FLD_DESCR,
                      validator: DescriptionValidator().validator(),
                      onFieldSubmitted: (_) => _setFocus(_nodeImgUrl, context),
                      node: _nodeDescr),
                  Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 20, right: 10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey)),
                        child: Obx(() => _controller.imgUrlPreviewObs.value
                            ? _animations.openContainer(
                                openingWidget:
                                    InventoryImageView(_product.title, _product.imageUrl),
                                closingWidget: FittedBox(
                                    child: Image.network(_urlControl.text,
                                        fit: BoxFit.cover)))
                            : Center(child: _icons.ico_edt_no_img()))),
                    Expanded(
                        child: CustomFormField(UrlProperties()).create(
                            product: _product,
                            initialValue: _product.imageUrl,
                            context: context,
                            label: _labels.INV_EDT_LBL_IMGURL(),
                            key: K_INV_ADDEDIT_FLD_IMGURL,
                            validator: UrlValidator().validator(),
                            onFieldSubmitted: (_) => _saveForm(context),
                            node: _nodeImgUrl,
                            controller: _urlControl))
                  ])
                ])))));
  }

  void _definingFormTask_updateOrAdd() {
    var findId = Get.parameters['id'] != null || widget._id != null;
    var _productId = widget._id == null ? Get.parameters['id'] : widget._id!;

    findId
        ? () {
            _product = _controller.getProductById(_productId!);
            _controller.imgUrlPreviewObs.value = true;
          }.call()
        : () {
            _product = Product.emptyInitialized();
            _nodeImgUrl.addListener(_previewImageUrl);
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

  void _previewImageUrl() {
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

    _product.id == null ? _save(_product, _context) : _update(_product, _context);
    Get.back();
  }

  void _save(Product _product, BuildContext _context) {
    // @formatter:off
    _controller.addProduct(_product).then((product) {
      _controller.updateInventoryProductsObs();
    }).whenComplete(() {
      SimpleSnackbar().show(_words.suces(), _messages.suces_inv_prod_add());
    }).catchError((onError) {
      Get.defaultDialog(
          title: _words.ops(), middleText: _messages.error_inv_prod(), textConfirm:
      _words.ok(),
          onConfirm:
      Get.back);
    });
    // @formatter:on
  }

  void _update(Product _product, BuildContext _context) {
    // @formatter:off
    _controller.updateProduct(_product).then((statusCode) {
      if (statusCode >= 200 && statusCode < 400) {
        _controller.updateInventoryProductsObs();
        SimpleSnackbar().show(_words.suces(), _messages.suces_inv_prod_upd());
      }
      if (statusCode >= 400) {
        Get.defaultDialog(
            title: _words.ops(), middleText: _messages.error_inv_prod(),
            textConfirm:
        _words.ok(),
            onConfirm: Get.back);
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