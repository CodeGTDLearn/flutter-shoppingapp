import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_validator/string_validator.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../../config/app_owasp_regex.dart';
import '../../../config/app_routes.dart';
import '../../../config/messages/field_validation.dart';
import '../../../config/titles_icons/app_core.dart';
import '../../../config/titles_icons/views/managed_product_edit.dart';
import '../../overview/product.dart';
import '../managed_products_controller.dart';

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

//  final ManagedProductsController _controller =
//      Get.put(ManagedProductsController());

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
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    if (_product.id == null) _controller.add(_product);
    if (_product.id != null) _controller.updatte(_product);
    Get.offNamed(MAN_PROD_ROUTE);
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
        appBar:
            AppBar(title: Text(MANAGED_PROD_LBL_ADD_APPBAR), actions: <Widget>[
          IconButton(icon: MANAGED_PROD_ICO_SAVE_APPBAR, onPressed: _saveForm)
        ]),
        body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _form,
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                  TextFormField(
                      initialValue: _product.title,
                      decoration:
                          InputDecoration(labelText: MANAGED_PROD_FIELD_TITLE),
                      textInputAction: TextInputAction.next,
                      maxLength: 15,
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _product.title = value,
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).requestFocus(_focusPrice),
                      validator: Validators.compose([
                        Validators.required(MSG_VALID_EMPTY),
                        Validators.patternString(SAFE_TEXT, MSG_VALID_TEXT),
                        Validators.minLength(5, MSG_VALID_MIN_SIZE_TIT)
                      ])),
                  TextFormField(
                      initialValue: _product.price == null
                          ? ZERO$AMOUNT
                          : _product.price.toString(),
                      decoration:
                          InputDecoration(labelText: MANAGED_PROD_FIELD_PRICE),
                      textInputAction: TextInputAction.next,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      onSaved: (value) => _product.price = double.parse(value),
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_focusDescript),
                      validator: Validators.compose([
                        Validators.required(MSG_VALID_EMPTY),
                        Validators.patternString(SAFE_NUMBER, MSG_VALID_NUMBER),
                        Validators.min(0, MSG_VALID_NEG)
                      ])),
                  TextFormField(
                      initialValue: _product.description,
                      decoration:
                          InputDecoration(labelText: MANAGED_PROD_FIELD_DESCR),
                      textInputAction: TextInputAction.next,
                      maxLength: 30,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (value) => _product.description = value,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_focusImgUrlNode),
                      validator: Validators.compose([
                        Validators.required(MSG_VALID_EMPTY),
                        Validators.patternString(SAFE_TEXT, MSG_VALID_TEXT),
                        Validators.minLength(10, MSG_VALID_MIN_SIZE_DESCR)
                      ])),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 20, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.5, color: Colors.grey)),
                            child: Container(
                                child: _imgUrlController.text.isEmpty
                                    ? Center(child: Text(MANAGED_PROD_IMG_TIT))
                                    : FittedBox(
                                        child: Image.network(
                                            _imgUrlController.text,
                                            fit: BoxFit.cover)))),
                        Expanded(
                            child: TextFormField(
                                //CONTROLLER e incompativel com INITIAL_VALUE
                                //initialValue: _product.imageUrl.toString(),
                                decoration: InputDecoration(
                                    labelText: MANAGED_PROD_FIELD_IMG_URL),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.url,
                                focusNode: _focusImgUrlNode,
                                //CONTROLLER e incompativel com INITIAL_VALUE
                                controller: _imgUrlController,
                                onSaved: (value) => _product.imageUrl = value,
                                onFieldSubmitted: (_) => _saveForm(),
                                validator: (value) {
                                  if (!isURL(value)) return MSG_VALID_URL;
                                  return null;
                                }))
                      ])
                ])))));
  }
}
