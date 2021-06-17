import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/components/progres_indicator.dart';
import '../../../core/components/snackbarr.dart';
import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/properties/app_properties.dart';
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
  final InventoryController _invController = Get.find();
  final OverviewController _ovController = Get.find();

  var _imgUrlPreviewObs = false.obs;

  bool _isInit = true;

  final _nodePrice = FocusNode();
  final _nodeDescr = FocusNode();
  final _nodeImgUrl = FocusNode();

  final _imgUrlController = TextEditingController();

  final _formKey = K_INV_FORM_GKEY;

  Product _product = Product();

  @override
  void initState() {
    _nodeImgUrl.addListener(_previewImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _invController.switchInventoryAddEditFormToCustomCircularProgrIndic();

      if (Get.arguments != null) {
        _product = _invController.getProductById(Get.arguments);
        _imgUrlController.text = _product.imageUrl;
        _imgUrlPreviewObs.value = true;
      }
      _invController.switchInventoryAddEditFormToCustomCircularProgrIndic();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nodePrice.dispose();
    _nodeDescr.dispose();
    _nodeImgUrl.removeListener(_previewImageUrl);
    _nodeImgUrl.dispose();
    _imgUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(Get.arguments == null
                ? INV_ADEDT_LBL_ADD_APPBAR
                : INV_ADEDT_LBL_EDIT_APPBAR),
            actions: [
              IconButton(
                  key: Key(K_INV_ADDEDIT_SAVE_BTN),
                  icon: ICO_INV_ADEDT_SAVE_BTN_APPBAR,
                  onPressed: () => _saveForm(context))
            ]),
        body: Obx(() => _invController.reloadInventoryEditPageObs.value
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
                          fieldName: INV_ADEDT_FLD_TITLE,
                          key: K_INV_ADDEDIT_FLD_TITLE,
                          function: (_) => _sendFocusTo(_nodePrice, context)),
                      CustomFormField().create(
                          product: _product,
                          context: context,
                          fieldName: INV_ADEDT_FLD_PRICE,
                          key: K_INV_ADDEDIT_FLD_PRICE,
                          function: (_) => _sendFocusTo(_nodeDescr, context),
                          node: _nodePrice),
                      CustomFormField().create(
                          product: _product,
                          context: context,
                          fieldName: INV_ADEDT_FLD_DESCR,
                          key: K_INV_ADDEDIT_FLD_DESCR,
                          function: (_) => _sendFocusTo(_nodeImgUrl, context),
                          node: _nodeDescr),
                      Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 20, right: 10),
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5, color: Colors.grey)),
                            child: Obx(() => (Container(
                                  child: _imgUrlPreviewObs.value
                                      ? _showProductImage(_imgUrlController.text)
                                      : Center(child: INV_ADEDT_NO_IMG_TIT),
                                )))),
                        Expanded(
                            child: CustomFormField().create(
                                product: _product,
                                context: context,
                                fieldName: INV_ADEDT_FLD_IMGURL,
                                key: K_INV_ADDEDIT_FLD_IMGURL,
                                function: (_) => _saveForm(context),
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
    var isImgUrlNull = _imgUrlController.text == null;
    var lostFocus = !_nodeImgUrl.hasFocus;

    if (lostFocus && (isImgUrlNull || isUnsafeUrl)) return null;
    if (lostFocus) _imgUrlPreviewObs.value = true;
  }

  void _saveForm(BuildContext _context) {
    // @formatter:off
    if (!_formKey.currentState.validate()) return;

    _formKey.currentState.save();

    _invController.switchInventoryAddEditFormToCustomCircularProgrIndic();

    _product.id.isNull
        ? _saveProduct(_product, _context)
        : _updateProduct(_product, _context);

    Navigator.pop(_context);
    // @formatter:on
  }

  void _saveProduct(Product _product, BuildContext _context) {
    // @formatter:off
    _invController
        .addProduct(_product)
        .then((product) {
      _invController.switchInventoryAddEditFormToCustomCircularProgrIndic();
      _invController.updateInventoryProductsObs();
      _ovController.updateFilteredProductsObs();
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
      _invController.switchInventoryAddEditFormToCustomCircularProgrIndic();});
    // @formatter:on
  }

  void _updateProduct(Product _product, BuildContext _context) {
    // @formatter:off
    _invController
        .updateProduct(_product)
        .then((statusCode) {
      if (statusCode >= 200 && statusCode < 400)  {
        _invController.switchInventoryAddEditFormToCustomCircularProgrIndic();
        _invController.updateInventoryProductsObs();
        _ovController.updateFilteredProductsObs();
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

  void _sendFocusTo(FocusNode node, BuildContext _context) {
    return FocusScope.of(_context).requestFocus(node);
  }
}
