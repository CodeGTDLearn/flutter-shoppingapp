import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../core/properties/app_owasp_regex.dart';
import '../../../core/properties/app_routes.dart';
import '../../../texts_icons_provider/app_generic_words.dart';
import '../../pages_generic_components/custom_snackbar.dart';
import '../controller/managed_products_controller.dart';
import '../core/messages_provided/message_field_form_validation_provided.dart';
import '../core/messages_provided/message_get_dialogs_provided.dart';
import '../core/texts_icons_provided/managed_product_edit_texts_icons_provided.dart';
import '../entities/product.dart';

class ManagedProductEditPage extends StatefulWidget {
  @override
  _ManagedProductEditPageState createState() => _ManagedProductEditPageState();
}

class _ManagedProductEditPageState extends State<ManagedProductEditPage> {
  bool _isInit = true;

  final _focusPrice = FocusNode();
  final _focusDescript = FocusNode();

  final _imgUrlController = TextEditingController();
  final _focusImgUrlNode = FocusNode();

  final _form = GlobalKey<FormState>();
  Product _product = Product();

  final ManagedProductsController _controller = Get.find();

  @override
  void initState() {
    _focusImgUrlNode.addListener(_previewImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _product = Get.arguments == null
          ? Product()
          : _controller.getById(Get.arguments);

      _imgUrlController.text = _product.imageUrl;
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  void _previewImageUrl() {
    var urlPattern =
        r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";

    var result = RegExp(urlPattern, caseSensitive: false)
        .firstMatch(_imgUrlController.text.trim());

    if (!_focusImgUrlNode.hasFocus) {
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
    _controller.toggleIsLoading();
    _product.id.isNull
        ? _controller
        .add(_product)
        .then((response) {
              _controller.toggleIsLoading();
              Get.offNamed(AppRoutes.MAN_PROD_ROUTE);
              CustomSnackBar.simple(SUCESS, SUCES_MAN_PROD_ADD);
        })
        .catchError((onError){
              Get.defaultDialog(
                  title: OPS,
                  middleText: ERROR_MAN_PROD_ADD,
                  textConfirm: OK,
                  onConfirm: Get.back);
              _controller.toggleIsLoading();
        })
        : _controller.updatte(_product);
    Get.offNamed(AppRoutes.MAN_PROD_ROUTE);
    // @formatter:on
  }

  @override
  void dispose() {
    _focusPrice.dispose();
    _focusDescript.dispose();

    _focusImgUrlNode.removeListener(_previewImageUrl);
    _focusImgUrlNode.dispose();
    _imgUrlController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(MAN_PROD_EDIT_LBL_ADD_APPBAR),
            actions: <Widget>[
              IconButton(
                  icon: MAN_PROD_EDIT_ICO_SAVE_APPBAR, onPressed: _saveForm)
            ]),
        body: Obx(() => _controller.reloadView.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                    key: _form,
                    child: SingleChildScrollView(
                        child: Column(children: <Widget>[
                      TextFormField(
                          initialValue: _product.title,
                          decoration: InputDecoration(
                              labelText: MAN_PROD_EDIT_FLD_TITLE),
                          textInputAction: TextInputAction.next,
                          maxLength: 15,
                          keyboardType: TextInputType.number,
                          onSaved: (value) => _product.title = value,
                          onFieldSubmitted: (value) =>
                              FocusScope.of(context).requestFocus(_focusPrice),
                          validator: Validators.compose([
                            Validators.required(EMPTY_FIELD),
                            Validators.patternString(SAFE_TEXT, VALID_TEXT),
                            Validators.minLength(5, VALID_SIZE_TITLE)
                          ])),
                      TextFormField(
//                          initialValue: _product.price != null
//                              ? _product.price.toString()
//                              : _product.price.toString(),
                          decoration: InputDecoration(
                              labelText: MAN_PROD_EDIT_FLD_PRICE,
                              hintText: ZERO$AMOUNT),
                          textInputAction: TextInputAction.next,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          onSaved: (value) =>
                              _product.price = double.parse(value),
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_focusDescript),
                          validator: Validators.compose([
                            Validators.required(EMPTY_FIELD),
                            Validators.patternString(
                                SAFE_NUMBER, VALID_NUMBER),
                            Validators.min(0, VALID_PRICE)
                          ])),
                      TextFormField(
                          initialValue: _product.description,
                          decoration: InputDecoration(
                              labelText: MAN_PROD_EDIT_FLD_DESCR),
                          textInputAction: TextInputAction.next,
                          maxLength: 30,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          onSaved: (value) => _product.description = value,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_focusImgUrlNode),
                          validator: Validators.compose([
                            Validators.required(EMPTY_FIELD),
                            Validators.patternString(SAFE_TEXT, VALID_TEXT),
                            Validators.minLength(10, VALID_SIZE_DESCRIPT)
                          ])),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
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
                                                Text(MAN_PROD_EDIT_IMG_TIT))
                                        : FittedBox(
                                            child: Image.network(
                                                _imgUrlController.text,
                                                fit: BoxFit.cover)))),
                            Expanded(
                                child: TextFormField(
                                    // ignore: lines_longer_than_80_chars
                                    //CONTROLLER e incompativel com INITIAL_VALUE

                                    //initialValue: _product.imageUrl.toString(),
                                    decoration: InputDecoration(
                                        labelText: MAN_PROD_EDIT_FLD_IMG_URL),
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.url,
                                    focusNode: _focusImgUrlNode,

                                    //CONTROLLER e incompativel com INITIAL_VALUE
                                    controller: _imgUrlController,
                                    onSaved: (value) =>
                                        _product.imageUrl = value,
                                    onFieldSubmitted: (_) => _saveForm(),
                                    validator: (value) {
                                      if (!isURL(value)) return VALID_URL;
                                      return null;
                                    }))
                          ])
                    ]))))));
  }
}
