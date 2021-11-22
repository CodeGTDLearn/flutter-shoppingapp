import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../core/keys/inventory_keys.dart';
import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/properties/app_properties.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../../core/texts_icons_provider/pages/inventory/inventory_edit_texts_icons_provided.dart';
import '../../../core/texts_icons_provider/pages/inventory/messages_snackbars_provided.dart';
import '../../overview/controller/overview_controller.dart';
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

class InventoryEditView extends StatefulWidget {
  @override
  _InventoryEditViewState createState() => _InventoryEditViewState();
}

class _InventoryEditViewState extends State<InventoryEditView> {
  final _inventoryController = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();

  bool _isInit = true;

  final _nodePrice = FocusNode();
  final _nodeDescription = FocusNode();
  final _nodeImgUrl = FocusNode();

  final _imgUrlController = TextEditingController();

  final _formKey = K_INV_FORM_GKEY;

  late Product _product;

  @override
  void initState() {
    _product = Product.emptyInitialized();
    _nodeImgUrl.addListener(_previewImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _inventoryController.switchInventoryAddEditFormToCustomCircularProgrIndic();

      if (Get.arguments != null) {
        _product = _inventoryController.getProductById(Get.arguments);
        _imgUrlController.text = _product.imageUrl;
        _inventoryController.setImgUrlPreviewObs(true);
      }

      _inventoryController.switchInventoryAddEditFormToCustomCircularProgrIndic();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nodePrice.dispose();
    _nodeDescription.dispose();
    _nodeImgUrl.removeListener(_previewImageUrl);
    _nodeImgUrl.dispose();
    _imgUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                Get.arguments == null ? INV_EDT_LBL_ADD_APPBAR : INV_EDT_LBL_EDIT_APPBAR),
            actions: [
              IconButton(
                  key: Key(K_INV_ADDEDIT_SAVE_BTN),
                  icon: ICO_INV_EDT_SAVE_BTN_APPBAR,
                  onPressed: () => _saveForm(context))
            ]),
        body: Obx(() => _inventoryController.reloadInventoryEditPageObs.value
            ? CustomIndicator()
            : Padding(
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
                          onFieldSubmitted: (_) => _setFocus(_nodeDescription, context),
                          node: _nodePrice,
                          controller: _product.price.toString() == '0.0'
                              ? _priceController()
                              : null),
                      CustomFormField(DescriptionProperties()).create(
                          product: _product,
                          initialValue: _product.description,
                          context: context,
                          label: INV_EDT_LBL_DESCR,
                          key: K_INV_ADDEDIT_FLD_DESCR,
                          validator: DescriptionValidator().validate(),
                          onFieldSubmitted: (_) => _setFocus(_nodeImgUrl, context),
                          node: _nodeDescription),
                      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 20, right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5, color: Colors.grey)),
                            child: Obx(() => (Container(
                                  child: _inventoryController.getImgUrlPreviewObs()
                                      ? _showProductImage(_imgUrlController.text)
                                      : Center(child: INV_EDT_NO_IMG_TIT),
                                )))),
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
                                controller: _imgUrlController))
                      ])
                    ]))))));
  }

  FittedBox _showProductImage(String url) {
    return FittedBox(child: Image.network(url, fit: BoxFit.cover));
  }

  void _previewImageUrl() {
    var isUnsafeUrl = RegExp(OWASP_SAFE_URL, caseSensitive: false)
            .firstMatch(_imgUrlController.text.trim()) ==
        null;
    var lostFocus = !_nodeImgUrl.hasFocus;

    if (lostFocus && isUnsafeUrl) return null;
    if (lostFocus) _inventoryController.setImgUrlPreviewObs(true);
  }

  void _saveForm(BuildContext _context) {
    // @formatter:off
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    _inventoryController.switchInventoryAddEditFormToCustomCircularProgrIndic();

    _product.id == null
        ? _saveProduct(_product, _context)
        : _updateProduct(_product, _context);

    Navigator.pop(_context);
    // @formatter:on
  }

  void _saveProduct(Product _product, BuildContext _context) {
    // @formatter:off
    _inventoryController.addProduct(_product).then((product) {
      _inventoryController.switchInventoryAddEditFormToCustomCircularProgrIndic();
      _inventoryController.updateInventoryProductsObs();
      _overviewController.updateFilteredProductsObs();
    }).whenComplete(() {
      SimpleSnackbar(SUCES, SUCESS_MAN_PROD_ADD).show();
    }).catchError((onError) {
      Get.defaultDialog(
          title: OPS, middleText: ERROR_MAN_PROD, textConfirm: OK, onConfirm: Get.back);
      _inventoryController.switchInventoryAddEditFormToCustomCircularProgrIndic();
    });
    // @formatter:on
  }

  void _updateProduct(Product _product, BuildContext _context) {
    // @formatter:off
    _inventoryController.updateProduct(_product).then((statusCode) {
      if (statusCode >= 200 && statusCode < 400) {
        _inventoryController.switchInventoryAddEditFormToCustomCircularProgrIndic();
        _inventoryController.updateInventoryProductsObs();
        _overviewController.updateFilteredProductsObs();
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