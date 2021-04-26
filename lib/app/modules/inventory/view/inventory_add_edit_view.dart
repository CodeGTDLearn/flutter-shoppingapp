import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/progres_indicator.dart';
import '../../../core/components/snackbarr.dart';
import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../overview/controller/overview_controller.dart';
import '../components/custom_text_form_field/custom_form_field.dart';
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
  final InventoryController _manProdController = Get.find();
  final OverviewController _ovViewController = Get.find();

  bool _isInit = true;

  final _focusPrice = FocusNode();
  final _focusDescr = FocusNode();
  final _focusUrlNode = FocusNode();

  final _imgUrlController = TextEditingController();

  // final _form = GlobalKey<FormState>();
  final _form = K_INV_FORM_GKEY;

  Product _product = Product();

  @override
  void initState() {
    _focusUrlNode.addListener(_previewImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _manProdController.switchManagedProdAddEditFormToCustomCircularProgrIndic();

      if (Get.arguments == null) {
        _manProdController.switchManagedProdAddEditFormToCustomCircularProgrIndic();
      } else {
        _product = _manProdController.getProductById(Get.arguments);
        _imgUrlController.text = _product.imageUrl;
        _manProdController.switchManagedProdAddEditFormToCustomCircularProgrIndic();
      }
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void _previewImageUrl() {
    var result = RegExp(SAFE_URL, caseSensitive: false)
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
    if (!_form.currentState.validate()) return;

    _form.currentState.save();

    _manProdController
        .switchManagedProdAddEditFormToCustomCircularProgrIndic();

    _product.id.isNull
        ? _saveProduct(_product, _context)
        : _updateProduct(_product, _context);

    Navigator.pop(_context);
    // @formatter:on
  }

  void _saveProduct(Product _product, BuildContext _context) {
    // @formatter:off
     _manProdController
        .addProduct(_product)
        .then((product) {
            _manProdController
              .switchManagedProdAddEditFormToCustomCircularProgrIndic();
            _manProdController.updateManagedProductsObs();
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
            _manProdController
              .switchManagedProdAddEditFormToCustomCircularProgrIndic();});
    // @formatter:on
  }

  void _updateProduct(Product _product, BuildContext _context) {
    // @formatter:off
    _manProdController
        .updateProduct(_product)
        .then((statusCode) {
            if (statusCode >= 200 && statusCode < 400)  {
              _manProdController
                  .switchManagedProdAddEditFormToCustomCircularProgrIndic();
              _manProdController.updateManagedProductsObs();
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
                ? INV_ADDEDIT_LBL_ADD_APPBAR
                : INV_ADDEDIT_LBL_EDT_APPBAR),
            actions: [
              IconButton(
                  key: Key(K_INV_AD_ED_SAVE_BTN),
                  icon: INV_ADDEDIT_ICO_SAVE_APPBAR,
                  onPressed: () => _saveForm(context))
            ]),
        body: Obx(() => _manProdController.reloadManagedProductsEditPageObs.value
            ? ProgresIndicator()
            : Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      CustomFormField().create(
                        product: _product,
                        context: context,
                        function: (_) => _requestfocus(_focusPrice, context),
                        fieldName: INV_ADDEDIT_FLD_TITLE,
                        key: K_INV_ADED_FLD_TIT,
                      ),
                      CustomFormField().create(
                        product: _product,
                        context: context,
                        function: (_) => _requestfocus(_focusDescr, context),
                        fieldName: INV_ADDEDIT_FLD_PRICE,
                        key: K_INV_ADED_FLD_PRICE,
                      ),
                      CustomFormField().create(
                        product: _product,
                        context: context,
                        function: (_) => _requestfocus(_focusUrlNode, context),
                        fieldName: INV_ADDEDIT_FLD_DESCR,
                        key: K_INV_ADED_FLD_DESC,
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
                                    ? Center(child: Text(INV_ADDEDIT_IMG_TIT))
                                    : FittedBox(
                                        child: Image.network(_imgUrlController.text,
                                            fit: BoxFit.cover)))),
                        Expanded(
                            child: CustomFormField().create(
                          product: _product,
                          context: context,
                          function: (_) => _saveForm(context),
                          fieldName: INV_ADDEDIT_FLD_IMG_URL,
                          key: K_INV_ADED_FLD_URL,
                          node: _focusUrlNode,
                          controller: _imgUrlController,
                        ))
                      ])
                    ]))))));
  }
}
