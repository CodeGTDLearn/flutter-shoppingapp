import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../pages_generic_components/custom_circ_progres_indicator.dart';
import '../../pages_generic_components/custom_snackbar.dart';
import '../components/custom_text_form_field/custom_text_form_field.dart';
import '../controller/managed_products_controller.dart';
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

  final _form = GlobalKey<FormState>();
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
      _controller.reloadManagedProductsAddEditPage();

      if (Get.arguments.isNull) {
        _controller.reloadManagedProductsAddEditPage();
      } else {
        _product = _controller.getProductById(Get.arguments);
        _imgUrlController.text = _product.imageUrl;
        _controller.reloadManagedProductsAddEditPage();
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

  void _saveForm() {
    // @formatter:off
    if (!_form.currentState.validate()) return;

    _form.currentState.save();

    _controller.reloadManagedProductsAddEditPage();

    _product.id.isNull ?
        _saveProduct(_product) :
        _updateProduct(_product);

    Get.offNamed(AppRoutes.MANAGED_PRODUCTS);
    // @formatter:on
  }

  Future<dynamic> _saveProduct(Product product) {
    // @formatter:off
    return _controller
        .saveProduct(product)
        .then((response) {
          _controller.reloadManagedProductsAddEditPage();
          _controller.reloadManagedProductsObs();
          Get.offNamed(AppRoutes.MANAGED_PRODUCTS);
          // CustomSnackbar.simple(
          //     message: SUCESS_MAN_PROD_ADD,
          //     context: context);
          SimpleSnackbar(SUCESS_MAN_PROD_ADD, context).show();
        })
        .catchError((onError) {
          Get.defaultDialog(
            title: OPS,
            middleText: ERROR_MAN_PROD,
            textConfirm: OK,
            onConfirm: Get.back);
          _controller.reloadManagedProductsAddEditPage();
        });
    // @formatter:on
  }

  Future<void> _updateProduct(Product product) {
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
            _controller.reloadManagedProductsAddEditPage();
            _controller.reloadManagedProductsObs();
            Get.offNamed(AppRoutes.MANAGED_PRODUCTS);
            // CustomSnackbar.simple(
            //     message: SUCESS_MAN_PROD_UPDT,
            //     context: context);
            SimpleSnackbar(SUCESS_MAN_PROD_UPDT, context).show();
          }
        });
    // @formatter:on
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
            title: Text(Get.arguments.isNull
                ? MAN_PROD_EDIT_LBL_ADD_APPBAR
                : MAN_PROD_EDIT_LBL_EDT_APPBAR),
            actions: [
              IconButton(
                icon: MAN_PROD_EDIT_ICO_SAVE_APPBAR,
                onPressed: _saveForm,
              )
            ]),
        body: Obx(() => _controller.reloadManagedProductsEditPage.value
            ? CustomCircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      CustomFormTextField().create(
                          _product,
                          context,
                          (_) =>
                              FocusScope.of(context).requestFocus(_focusPrice),
                          "title"),
                      CustomFormTextField().create(
                          _product,
                          context,
                          (_) =>
                              FocusScope.of(context).requestFocus(_focusDescr),
                          "price"),
                      CustomFormTextField().create(
                          _product,
                          context,
                          (_) => FocusScope.of(context)
                              .requestFocus(_focusUrlNode),
                          "description"),
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
                                            child: Text(MAN_PROD_EDIT_IMG_TIT))
                                        : FittedBox(
                                            child: Image.network(
                                                _imgUrlController.text,
                                                fit: BoxFit.cover)))),
                            Expanded(
                                child: CustomFormTextField().create(
                              _product,
                              context,
                              (_) => _saveForm(),
                              "url",
                              node: _focusUrlNode,
                              controller: _imgUrlController,
                            ))
                          ])
                    ]))))));
  }
}

// var urlPattern =
//     r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
//
// var result = RegExp(urlPattern, caseSensitive: false)
//     .firstMatch(_imgUrlController.text.trim());
