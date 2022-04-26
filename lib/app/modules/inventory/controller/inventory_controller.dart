import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/components/modal/core_modal_material.dart';
import '../../../core/components/modal/i_core_adaptive_modal.dart';
import '../../../core/components/snackbar/core_snackbar.dart';
import '../../../core/properties/properties.dart';
import '../../../core/texts/core_labels.dart';
import '../../../core/texts/core_messages.dart';
import '../../cart/entity/cart_item.dart';
import '../entity/product.dart';
import '../service/i_inventory_service.dart';

class InventoryController extends GetxController {
  final _messages = Get.find<CoreMessages>();
  final _labels = Get.find<CoreLabels>();

  // late _modal;

  final IInventoryService service;

  var productsStockQtdeObs = 0.obs;
  var productCodeObs = "".obs;
  var arrivalDateObs = "".obs;
  var productsObs = <Product>[].obs;
  var productImageUrlPreviewObs = false.obs;

  var enableDiscountSliderObs = false.obs;
  var discountObs = 0.0.obs;

  InventoryController({required this.service});

  void setDiscountSlider(double discount) {
    discountObs.value = discount;
  }

  void enableDiscountSlider(bool enable) {
    enableDiscountSliderObs.value = enable;
  }

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    productsObs.assignAll([]);
    getProducts();
    super.onInit();
  }

  Future<List<Product>> getProducts() {
    // @formatter:off
    return service
            .getProducts()
            .then((response) {
                 productsObs.assignAll(response);
                 // response == null
                 //     ? inventoryProductsObs.assignAll([])
                 //     : inventoryProductsObs.assignAll(response);
                 return productsObs.toList();})
            .catchError((onError) => throw onError);
    // @formatter:on
  }

  int getProductsQtde() {
    return service.getProductsQtde();
  }

  Product getProductById(String id) {
    return service.getProductById(id);
  }

  Future<Product> addProduct(Product _product) {
    // @formatter:off
    return service
            .addProduct(_product)
            .then((addedProduct) {
                   return addedProduct;})
            .catchError((onError) => throw onError);
    // @formatter:on
  }

  Future<int> updateProduct(Product product) {
    return service.updateProduct(product).then((statusCode) => statusCode);
  }

  Future<int> deleteProduct(String id) {
    // @formatter:off
    var responseFuture = service.deleteProduct(id).then((statusCode) {
      if (statusCode >= 400) {
        productsObs.assignAll(service.getLocalDataInventoryProducts());
      }
      return statusCode;
    });

    productsObs.assignAll(service.getLocalDataInventoryProducts());

    return responseFuture;
    // @formatter:on
  }

  void updateInventoryProductsObs() {
    productsObs.assignAll(service.getLocalDataInventoryProducts());
  }

  Future<void> modalStockAddOrRemoveItems(
    context, {
    required Product item,
    required bool addition,
  }) async {
    var _modal = Get.put<ICoreAdaptiveModal>(CoreModalMaterial(), tag: "deleteModal");
    var _textFieldController = TextEditingController();

    return _modal.create(
      context,
      title: _messages.update_stock_title,
      contentField: true,
      contentFieldKeyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.deny(RegExp('[,-.]')),
        FilteringTextInputFormatter.deny(RegExp(' ')),
      ],
      contentFieldPlaceholder:
          addition ? _messages.stock_addition_hint : _messages.stock_subtraction_hint,
      contentFieldController: _textFieldController,
      labelYes: _labels.yes,
      labelNo: _labels.no,
      actionYes: () async {
        var _number = int.parse(_textFieldController.text.trim());
        var stockQtde = item.stockQtde;
        addition
            ? () async {
                item.stockQtde = stockQtde + _number;
                await updateProduct(item).then((status) async {
                  productsStockQtdeObs.value = item.stockQtde;
                  Get.back();
                  Get.delete(tag: "deleteModal");
                });
              }.call()
            : item.stockQtde >= _number
                ? () async {
                    item.stockQtde = stockQtde - _number;
                    await updateProduct(item).then((status) async {
                      productsStockQtdeObs.value = item.stockQtde;
                      Get.back();
                    });
                  }.call()
                : CoreSnackbar().show(_labels.ops, _messages.zero_stock_message);
        Get.delete(tag: "deleteModal");
      },
      actionNo: Get.back,
    );
  }

  CurrencyTextFieldController priceController() {
    return CurrencyTextFieldController(
        rightSymbol: CURRENCY_FORMAT,
        decimalSymbol: DECIMAL_SYMBOL,
        thousandSymbol: THOUSAND_SYMBOL);
  }

  void saveProductInForm(Product _product, BuildContext _context) {
    // @formatter:off
    addProduct(_product).then((product) {
      updateInventoryProductsObs();
    }).whenComplete(() {
      CoreSnackbar().show(_labels.suces, _messages.suces_inv_prod_add);
    }).catchError((onError) {
      Get.defaultDialog(
          title: _labels.ops, middleText: _messages.error_inv_prod, textConfirm:
      _labels.ok(),
          onConfirm:
          Get.back);
    });
    // @formatter:on
  }

  void updateProductInForm(Product _product, BuildContext _context) {
    // @formatter:off
    updateProduct(_product).then((statusCode) {
      if (statusCode >= 200 && statusCode < 400) {
        updateInventoryProductsObs();
        CoreSnackbar().show(_labels.suces, _messages.suces_inv_prod_upd);
      }
      if (statusCode >= 400) {
        Get.defaultDialog(
            title: _labels.ops, middleText: _messages.error_inv_prod,
            textConfirm:
            _labels.ok,
            onConfirm: Get.back);
      }
    });
    // @formatter:on
  }

  void scanCode({var barcode = true, successBeep = true}) async {
    // @formatter:off
    return FlutterBarcodeScanner
           .scanBarcode(
              "#ff6666",
              "Cancel",
              true,
              barcode ? ScanMode.BARCODE : ScanMode.QR)
           .then((scannedCode) async {
             var date = DateTime.now();
              productCodeObs.value = scannedCode;
              arrivalDateObs.value = "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}";
              // await Future.delayed(Duration(milliseconds: 1000));
              if (successBeep) FlutterBeep.beep();
              // await Future.delayed(Duration(milliseconds: 5000));
              // Get.back();
           })
           .catchError((onError) {
              Get.defaultDialog(content: Text(_messages.code_read_error_message));
            });
    // @formatter:on
  }

  bool checkItemAvailability(String inventoryItem) {
    return service.checkItemAvailability(inventoryItem);
  }

  updateStockItemsQuantity(Map<String, CartItem> cartItems) {
    return service.updateStockItemsQuantity(cartItems);
  }
}