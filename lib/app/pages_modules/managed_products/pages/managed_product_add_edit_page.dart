import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/app_generic_words.dart';
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
      _controller.toggleReloadManagedProductsEditPage();

      if (Get.arguments.isNull) {
        _controller.toggleReloadManagedProductsEditPage();
      } else {
        _product = _controller.getProductById(Get.arguments);
        _imgUrlController.text = _product.imageUrl;
        _controller.toggleReloadManagedProductsEditPage();
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

    _controller.toggleReloadManagedProductsEditPage();

    _product.id.isNull ?
        _saveProduct(_product) :
        _updateProduct(_product);

    Get.offNamed(AppRoutes.MAN_PROD);
    // @formatter:on
  }

  Future<dynamic> _saveProduct(Product product) {
    // @formatter:off
    return _controller
        .saveProduct(product)
        .then((response) {
          _controller.toggleReloadManagedProductsEditPage();
//todo 2.1: Criar Get_dataSavingProducts no controller, getando
// o_dataSavingProducts do service, e usa-lo aqui, AO INVES DE FAZER UM NOVA
// REQUISICAO getProducts()
          _controller.getProducts();
          Get.offNamed(AppRoutes.MAN_PROD);
          CustomSnackBar.simple(SUCESS, SUCESS_MAN_PROD_ADD);
        })
        .catchError((onError) {
          Get.defaultDialog(
            title: OPS,
            middleText: ERROR_MAN_PROD,
            textConfirm: OK,
            onConfirm: Get.back);
          _controller.toggleReloadManagedProductsEditPage();
        });
    // @formatter:on
  }

  Future<void> _updateProduct(Product product) {
    // @formatter:off
    return _controller
        .updateProduct(product)
        .then((statusCode) {
          //todo 03: insert the next 3 lines of code, inside Else/CustomSnackBar
          _controller.toggleReloadManagedProductsEditPage();
//todo 2.2: Criar Get_dataSavingProducts no controller, getando
// o_dataSavingProducts do service, e usa-lo aqui, AO INVES DE FAZER UM NOVA
// REQUISICAO getProducts()
          _controller.getProducts();
          Get.offNamed(AppRoutes.MAN_PROD);
          if (statusCode >= 400) {
            Get.defaultDialog(
                title: OPS,
                middleText: ERROR_MAN_PROD,
                textConfirm: OK,
                onConfirm: Get.back);
          } else {
            CustomSnackBar.simple(SUCESS, SUCESS_MAN_PROD_UPDT);
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
            ? Center(child: CircularProgressIndicator())
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

//-------------------------TITLE-----------------------------
// TextFormField(
//     initialValue: _product.title,
//     decoration: InputDecoration(
//         labelText: MAN_PROD_EDIT_FLD_TITLE,
//         hintText: TITLE),
//     textInputAction: TextInputAction.next,
//     maxLength: 15,
//     keyboardType: TextInputType.number,
//     validator: Validators.compose([
//       Validators.required(EMPTY_FIELD),
//       Validators.patternString(SAFE_TEXT, VALID_TEXT),
//       Validators.minLength(5, VALID_SIZE_TITLE)
//     ])),
//     onFieldSubmitted: (_) =>FocusScope.of(context).requestFocus(_focusPrice),
//     onSaved: (value) => _product.title = value,

//-------------------------URL-----------------------------
// TextFormField(
//     // ignore: lines_longer_than_80_chars
//     //CONTROLLER e incompativel com INITIAL_VALUE
//     //initialValue: _product.imageUrl.toString(),
//     decoration: InputDecoration(
//         labelText: MAN_PROD_EDIT_FLD_IMG_URL,
//         hintText: URL),
//     textInputAction: TextInputAction.done,
//     maxLength: 130,
//     keyboardType: TextInputType.url,
//     validator: (value) {
//       if (!isURL(value)) return VALID_URL;
//       return null;
//     }),
//     onFieldSubmitted: (_) => _saveForm(),
//     onSaved: (value) => _product.imageUrl = value,

//     focusNode: _focusImgUrlNode,

//     //CONTROLLER e incompativel com INITIAL_VALUE
//     controller: _imgUrlController,

//-------------------------DESCRIPT-----------------------------
// TextFormField(
//     initialValue: _product.description,
//     decoration: InputDecoration(
//         labelText: MAN_PROD_EDIT_FLD_DESCR,
//         hintText: DESCRIPT),
//     textInputAction: TextInputAction.next,
//     maxLength: 30,
//     maxLines: 3,
//     keyboardType: TextInputType.multiline,
//     validator: Validators.compose([
//       Validators.required(EMPTY_FIELD),
//       Validators.patternString(SAFE_TEXT, VALID_TEXT),
//       Validators.minLength(10, VALID_SIZE_DESCRIPT)
//     ])),
//     onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_focusImgUrlNode),
//     onSaved: (value) => _product.description = value,

//-------------------------PRICE-----------------------------
// TextFormField(
//     initialValue: _product.price == null
//         ? _product.price
//         : _product.price.toString(),
////     decoration: InputDecoration(
//         labelText: MAN_PROD_EDIT_FLD_PRICE,
//         hintText: ZERO$AMOUNT),
////     textInputAction: TextInputAction.next,
//     maxLength: 6,
//     keyboardType: TextInputType.number,
//     validator: Validators.compose([
//       Validators.required(EMPTY_FIELD),
//       Validators.patternString(SAFE_NUMBER, VALID_NUMBER),
//       Validators.min(0, VALID_PRICE)
//     ])),
//     onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_focusDescript),
//     onSaved: (value) =>_product.price = double.parse(value.trim()),


// var urlPattern =
//     r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
//
// var result = RegExp(urlPattern, caseSensitive: false)
//     .firstMatch(_imgUrlController.text.trim());
