import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../core/keys/inventory_keys.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/generic_words.dart';
import '../../../core/texts_icons_provider/pages/inventory/inventory_item_icons_provided.dart';
import '../../../core/texts_icons_provider/pages/inventory/messages_snackbars_provided.dart';
import '../../overview/controller/overview_controller.dart';
import '../controller/inventory_controller.dart';
import '../entity/product.dart';

class InventoryItem extends StatelessWidget {
  final Product product;
  final _inventoryController = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();

  InventoryItem({required this.product});

  @override
  Widget build(BuildContext context) {
    var _id = product.id!;
    var _title = product.title;
    var _imageUrl = product.imageUrl;

    return ListTile(
        key: Key('$K_INV_ITEM_KEY$_id'),
        leading: CircleAvatar(backgroundImage: NetworkImage(_imageUrl)),
        title: Text(_title),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  key: Key('$K_INV_UPD_BTN$_id'),
                  icon: INV_ITEM_UPD_ICO,
                  onPressed: () =>
                      Get.toNamed(AppRoutes.INVENTORY_ADDEDIT_PRODUCT, arguments: _id),
                  color: Theme.of(context).errorColor),
              IconButton(
                  key: Key('$K_INV_DEL_BTN$_id'),
                  icon: INV_ITEM_DEL_ICO,
                  // @formatter:off
                  onPressed: () =>
                      _inventoryController.deleteProduct(_id).then((statusCode) {
                        if (statusCode >= 200 && statusCode < 400) {
                          _inventoryController.updateInventoryProductsObs();
                          _overviewController.deleteProduct(_id);
                          _overviewController.updateFilteredProductsObs();
                          SimpleSnackbar(SUCES, SUCESS_MAN_PROD_DEL).show();
                        }
                        if (statusCode >= 400) {
                          SimpleSnackbar(OPS, ERROR_MAN_PROD).show();
                        }
                      }),
                  // @formatter:on
                  color: Theme.of(context).errorColor),
            ])));
  }
}