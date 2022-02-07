import 'package:currency_textfield/currency_textfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/core/components/modal/core_modal_material.dart';
import 'package:shopingapp/app/core/components/snackbar/core_snackbar.dart';
import 'package:shopingapp/app/core/properties/properties.dart';

import '../../../core/components/modal/i_core_adaptive_modal.dart';
import '../../../core/texts/core_labels.dart';
import '../../../core/texts/core_messages.dart';
import '../entity/product.dart';
import '../service/i_inventory_service.dart';

class InventoryController extends GetxController {
  final _messages = Get.find<CoreMessages>();
  final _labels = Get.find<CoreLabels>();

  // late _modal;

  final IInventoryService service;

  var productsStockQtdeObs = 0.obs;
  var inventoryProductsObs = <Product>[].obs;
  var renderInventoryItemDetailsViewObs = false.obs;
  var imgUrlPreviewObs = false.obs;
  var inventoryImageZoomObs = false.obs;

  InventoryController({required this.service});

  // GERENCIA DE ESTADO REATIVA ou SIMPLES - COM O GET
  @override
  void onInit() {
    inventoryProductsObs.assignAll([]);
    getProducts();
    super.onInit();
  }

  void toggleInventoryImageZoomObs() {
    inventoryImageZoomObs.value = !inventoryImageZoomObs.value;
  }

  Future<List<Product>> getProducts() {
    // @formatter:off
    return service
            .getProducts()
            .then((response) {
                 inventoryProductsObs.assignAll(response);
                 // response == null
                 //     ? inventoryProductsObs.assignAll([])
                 //     : inventoryProductsObs.assignAll(response);
                 return inventoryProductsObs.toList();})
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
        inventoryProductsObs.assignAll(service.getLocalDataInventoryProducts());
      }
      return statusCode;
    });

    inventoryProductsObs.assignAll(service.getLocalDataInventoryProducts());

    return responseFuture;
    // @formatter:on
  }

  void switchInventoryItemFormToCoreAdaptiveIndicator() {
    renderInventoryItemDetailsViewObs.value = !renderInventoryItemDetailsViewObs.value;
  }

  void updateInventoryProductsObs() {
    inventoryProductsObs.assignAll(service.getLocalDataInventoryProducts());
  }

  Future<void> modalStockQtdeUpdateAddingOrSubtractingItems(
    context, {
    required Product product,
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
        var stockQtde = product.stockQtde;
        addition
            ? () async {
                product.stockQtde = stockQtde + _number;
                await updateProduct(product).then((status) async {
                  productsStockQtdeObs.value = product.stockQtde;
                  Get.back();
                  Get.delete(tag: "deleteModal");
                });
              }.call()
            : product.stockQtde >= _number
                ? () async {
                    product.stockQtde = stockQtde - _number;
                    await updateProduct(product).then((status) async {
                      productsStockQtdeObs.value = product.stockQtde;
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

  Future<String> scanQRCode() async {
    return FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.QR,
    ).then((scannedQrCode) => scannedQrCode);
  }

  Future<String> scanBarCode() async {
    return FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      true,
      ScanMode.BARCODE,
    ).then((scannedQrCode) => scannedQrCode);
  }
}

// return repo
//     .getNotonlineElevators()
//     .catchError((onError) {
//        Get.defaultDialog(content: Text(onError.toString()));
//        return <Elevator>[];}
//     );