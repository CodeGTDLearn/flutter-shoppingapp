import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../custom_widgets/custom_circ_progr_indicator.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../components/custom_text_form_field/custom_form_field.dart';
import '../controller/managed_products_controller.dart';
import '../core/managed_products_widget_keys.dart';
import '../core/messages/messages_snackbars_provided.dart';
import '../core/texts_icons/managed_product_edit_texts_icons_provided.dart';
import '../entities/product.dart';

class ManagedProductAddEditPage extends StatefulWidget {
  @override
  _ManagedProductAddEditPageState createState() =>
      _ManagedProductAddEditPageState();
}

class _ManagedProductAddEditPageState extends State<ManagedProductAddEditPage> {
  bool _isInit = true;

  final _focusPrice = FocusNode();
  final _focusDescr = FocusNode();
  final _focusUrlNode = FocusNode();

  final _imgUrlController = TextEditingController();

  // final _form = GlobalKey<FormState>();
  final _form = K_MAN_PROD_ADDEDIT_GLOBAL_KEY;

  Product _product = Product();

  final ManagedProductsController _controller = Get.find();

  @override
  void initState() {
    _focusUrlNode.addListener(_previewImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _controller.switchManagedProdAddEditFormAndCustomCircularProgrIndic();

      if (Get.arguments == null) {
        _controller.switchManagedProdAddEditFormAndCustomCircularProgrIndic();
      } else {
        _product = _controller.getProductById(Get.arguments);
        _imgUrlController.text = _product.imageUrl;
        _controller.switchManagedProdAddEditFormAndCustomCircularProgrIndic();
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

    _controller.switchManagedProdAddEditFormAndCustomCircularProgrIndic();

    _product.id.isNull ?
        _saveProduct(_product, _context) :
        _updateProduct(_product, _context);
    // @formatter:on
  }

  Future<dynamic> _saveProduct(Product _product, BuildContext _context) {
    // @formatter:off
    return _controller
        .addProduct(_product)
        .then((product) {
          _controller.switchManagedProdAddEditFormAndCustomCircularProgrIndic();
          _controller.reloadManagedProductsObs();
          Get.offNamed(AppRoutes.MANAGED_PRODUCTS);
        })
        .whenComplete((){
            Get.snackbar("title", "message");
            // SimpleSnackbar(SUCESS_MAN_PROD_ADD,_context).show();
        })
        .catchError((onError) {
          Get.defaultDialog(
            title: OPS,
            middleText: ERROR_MAN_PROD,
            textConfirm: OK,
            onConfirm: Get.back);
          _controller.switchManagedProdAddEditFormAndCustomCircularProgrIndic();
        });
    // @formatter:on
  }

  Future<void> _updateProduct(Product product, BuildContext _context) {
    // @formatter:off
    return _controller
        .updateProduct(product)
        .then((statusCode) {
          if (statusCode >= 400) {
            Get.defaultDialog(
                title: OPS,
                middleText: ERROR_MAN_PROD,
                textConfirm: OK,
                onConfirm: Get.back);
          } else {
            _controller.switchManagedProdAddEditFormAndCustomCircularProgrIndic();
            _controller.reloadManagedProductsObs();
            Get.offNamed(AppRoutes.MANAGED_PRODUCTS);
            SimpleSnackbar(SUCESS_MAN_PROD_UPDT, _context).show();
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
                ? MAN_PROD_ADDEDIT_LBL_ADD_APPBAR
                : MAN_PROD_ADDEDIT_LBL_EDT_APPBAR),
            actions: [
              IconButton(
                  key: Key(K_MAN_PROD_ADDEDIT_SAVE_BTN),
                  icon: MAN_PROD_ADDEDIT_ICO_SAVE_APPBAR,
                  onPressed: () => _saveForm(context))
            ]),
        body: Obx(() => _controller.reloadManagedProductsEditPageObs.value
            ? CustomCircProgrIndicator()
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
                        fieldName: MAN_PROD_ADDEDIT_FLD_TITLE,
                        key: K_MAN_PROD_ADDEDIT_FLD_TIT,
                      ),
                      CustomFormField().create(
                        product: _product,
                        context: context,
                        function: (_) => _requestfocus(_focusDescr, context),
                        fieldName: MAN_PROD_ADDEDIT_FLD_PRICE,
                        key: K_MAN_PROD_ADDEDIT_FLD_PRICE,
                      ),
                      CustomFormField().create(
                        product: _product,
                        context: context,
                        function: (_) => _requestfocus(_focusUrlNode, context),
                        fieldName: MAN_PROD_ADDEDIT_FLD_DESCR,
                        key: K_MAN_PROD_ADDEDIT_FLD_DESC,
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(top: 20, right: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey)),
                                child: Container(
                                    child: _imgUrlController.text.isEmpty
                                        ? Center(
                                            child:
                                                Text(MAN_PROD_ADDEDIT_IMG_TIT))
                                        : FittedBox(
                                            child: Image.network(
                                                _imgUrlController.text,
                                                fit: BoxFit.cover)))),
                            Expanded(
                                child: CustomFormField().create(
                              product: _product,
                              context: context,
                              function: (_) => _saveForm(context),
                              fieldName: MAN_PROD_ADDEDIT_FLD_IMG_URL,
                              key: K_MAN_PROD_ADDEDIT_FLD_URL,
                              node: _focusUrlNode,
                              controller: _imgUrlController,
                            ))
                          ])
                    ]))))));
  }
}
