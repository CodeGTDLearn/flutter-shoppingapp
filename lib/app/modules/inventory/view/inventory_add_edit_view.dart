import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/progres_indicator.dart';
import '../../../core/components/snackbarr.dart';
import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../overview/controller/overview_controller.dart';
import '../components/custom_form_field/custom_form_field.dart';
import '../controller/inventory_controller.dart';
import '../core/inventory_keys.dart';
import '../core/messages/messages_snackbars_provided.dart';
import '../core/texts_icons/inventory_edit_texts_icons_provided.dart';
import '../entities/product.dart';

class InventoryAddEditView extends StatefulWidget {
  @override
  _InventoryAddEditViewState createState() => _InventoryAddEditViewState();
}

class _InventoryAddEditViewState extends State<InventoryAddEditView> {
  final InventoryController _inventController = Get.find();
  final OverviewController _ovViewController = Get.find();

  bool _isInit = true;

  final _focusPrice = FocusNode();
  final _focusDescr = FocusNode();
  final _focusUrlNode = FocusNode();

  final _imgUrlController = TextEditingController();

  final _formKey = K_INV_FORM_GKEY;

  Product _product = Product();

  @override
  void initState() {
    _focusUrlNode.addListener(_previewImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _inventController.switchInventoryAddEditFormToCustomCircularProgrIndic();

      if (Get.arguments == null) {
        _inventController.switchInventoryAddEditFormToCustomCircularProgrIndic();
      } else {
        _product = _inventController.getProductById(Get.arguments);
        _imgUrlController.text = _product.imageUrl;
        _inventController.switchInventoryAddEditFormToCustomCircularProgrIndic();
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void _previewImageUrl() {
    var result = RegExp(OWASP_SAFE_URL, caseSensitive: false)
        .firstMatch(_imgUrlController.text.trim());

    if (!_focusUrlNode.hasFocus) {
      if (_imgUrlController.text == null || result == null) {
        return null;
      }
      setState(() {});
    }
  }

  void _saveForm(BuildContext _context) {
    // @formatter:off
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    _inventController.switchInventoryAddEditFormToCustomCircularProgrIndic();

    _product.id.isNull
        ? _saveProduct(_product, _context)
        : _updateProduct(_product, _context);

    Navigator.pop(_context);
    // @formatter:on
  }

  void _saveProduct(Product _product, BuildContext _context) {
    // @formatter:off
     _inventController
        .addProduct(_product)
        .then((product) {
            _inventController.switchInventoryAddEditFormToCustomCircularProgrIndic();
            _inventController.updateInventoryProductsObs();
            _ovViewController.updateFilteredProductsObs();
        })
        .whenComplete(() {
          SimpleSnackbar(SUCES, SUCESS_MAN_PROD_ADD).show();
        })
        .catchError((onError) {
            Get.defaultDialog(
            title: OPS,
            middleText: ERROR_MAN_PROD,
            textConfirm: OK,
            onConfirm: Get.back);
            _inventController.switchInventoryAddEditFormToCustomCircularProgrIndic();});
    // @formatter:on
  }

  void _updateProduct(Product _product, BuildContext _context) {
    // @formatter:off
    _inventController
        .updateProduct(_product)
        .then((statusCode) {
            if (statusCode >= 200 && statusCode < 400)  {
              _inventController.switchInventoryAddEditFormToCustomCircularProgrIndic();
              _inventController.updateInventoryProductsObs();
              _ovViewController.updateFilteredProductsObs();
              SimpleSnackbar(SUCES, SUCESS_MAN_PROD_UPDT).show();
            }
            if (statusCode >= 400) {
              Get.defaultDialog(
                  title: OPS,
                  middleText: ERROR_MAN_PROD,
                  textConfirm: OK,
                  onConfirm: Get.back);
            }
        });
    // @formatter:on
  }

  void _requestfocus(FocusNode node, BuildContext _context) {
    return FocusScope.of(_context).requestFocus(node);
  }

  @override
  void dispose() {
    _focusPrice.dispose();
    _focusDescr.dispose();
    _focusUrlNode.removeListener(_previewImageUrl);
    _focusUrlNode.dispose();
    _imgUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(Get.arguments == null
                ? INVENT_ADDEDIT_LBL_ADD_APPBAR
                : INVENT_ADDEDIT_LBL_EDIT_APPBAR),
            actions: [
              IconButton(
                  key: Key(K_INV_ADDEDIT_SAVE_BTN),
                  icon: ICO_INVENT_ADDEDIT_SAVE_BTN_APPBAR,
                  onPressed: () => _saveForm(context))
            ]),
        body: Obx(() => _inventController.reloadInventoryEditPageObs.value
            ? ProgresIndicator()
            : Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      CustomFormField().create(
                        product: _product,
                        context: context,
                        function: (_) => _requestfocus(_focusPrice, context),
                        fieldName: INVENT_ADDEDIT_FLD_TITLE,
                        key: K_INV_ADDEDIT_FLD_TITLE,
                      ),
                      CustomFormField().create(
                        product: _product,
                        context: context,
                        function: (_) => _requestfocus(_focusDescr, context),
                        fieldName: INVENT_ADDEDIT_FLD_PRICE,
                        key: K_INV_ADDEDIT_FLD_PRICE,
                      ),
                      CustomFormField().create(
                        product: _product,
                        context: context,
                        function: (_) => _requestfocus(_focusUrlNode, context),
                        fieldName: INVENT_ADDEDIT_FLD_DESCR,
                        key: K_INV_ADDEDIT_FLD_DESCR,
                      ),
                      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 20, right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5, color: Colors.grey)),
                            child: Container(
                                child: _imgUrlController.text.isEmpty
                                    ? Center(child: Text(INVENT_ADDEDIT_IMG_TIT))
                                    : FittedBox(
                                        child: Image.network(_imgUrlController.text,
                                            fit: BoxFit.cover)))),
                        Expanded(
                            child: CustomFormField().create(
                          product: _product,
                          context: context,
                          function: (_) => _saveForm(context),
                          fieldName: INVENT_ADDEDIT_FLD_IMGURL,
                          key: K_INV_ADDEDIT_FLD_IMGURL,
                          node: _focusUrlNode,
                          controller: _imgUrlController,
                        ))
                      ])
                    ]))))));
  }
}
