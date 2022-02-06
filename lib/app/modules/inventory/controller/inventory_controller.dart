import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/core/components/modal/i_core_adaptive_modal.dart';
import 'package:shopingapp/app/core/texts/core_labels.dart';
import 'package:shopingapp/app/core/texts/core_messages.dart';

import '../entity/product.dart';
import '../service/i_inventory_service.dart';

class InventoryController extends GetxController {
  final _messages = Get.find<CoreMessages>();
  final _labels = Get.find<CoreLabels>();
  late final _modal;

  final IInventoryService service;

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
    _modal = Get.find<ICoreAdaptiveModal>();
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

  void switchInventoryItemFormToCustomIndicator() {
    renderInventoryItemDetailsViewObs.value = !renderInventoryItemDetailsViewObs.value;
  }

  void updateInventoryProductsObs() {
    inventoryProductsObs.assignAll(service.getLocalDataInventoryProducts());
  }

  Future<void> modalToConfirmingStatusChange(
      context,
      Product product,
      ) async {
    return _modal.create(
      context,
      _messages.prod_add_stock_conf,
      _labels.yes,
      _labels.no,
          () async {
        // await updateStatus(product.id.toString()).then((status) async {
        //   if (status == 'offline') {
        //     CoreIndicatorAdaptive.message(
        //         message: _messages.errorUpdateTryAgain, fontSize: 20);
        //   }
        //   if (status == 'online') await _elevatorUpdateOkClosingModal(status, product);
        //   if (status == 'error') _elevatorUpdateFailingImpedingTheElevatorUpdate();
        // });
      },
          () {
        // statusButtonAnimation(color: Colors.red, blur: 15);
        Get.back();
        // _buttonScaleObs.value = false;
      },
    );
  }
}