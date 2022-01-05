import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../../core/custom_widgets/snackbar/simple_snackbar.dart';
import '../../../../core/icons/modules/inventory/inventory_icons.dart';
import '../../../../core/keys/modules/inventory_keys.dart';
import '../../../../core/properties/app_properties.dart';
import '../../../../core/texts/general_words.dart';
import '../../../../core/texts/messages.dart';
import '../../../overview/controller/overview_controller.dart';
import '../../controller/inventory_controller.dart';
import '../../entity/product.dart';
import '../../view/inventory_details_view.dart';
import 'icustom_listtile.dart';

class SimpleListTile implements ICustomListTile {
  final _icons = Get.find<InventoryIcons>();
  final _messages = Get.find<Messages>();
  final _words = Get.find<GeneralWords>();

  final _inventoryController = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();

  @override
  Widget customListTile(Product product) {
    var _id = product.id!;
    var _context = APP_CONTEXT_GLOBAL_KEY.currentContext;

    return ListTile(
        key: Key('$K_INV_ITEM_KEY$_id'),
        leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
        title: Text(product.title),
        trailing: Container(
            width: 100,
            child: Row(children: <Widget>[
              IconButton(
                  key: Key('$K_INV_UPD_BTN$_id'),
                  icon: _icons.icon_update(),
                  onPressed: () => Get.to(() => InventoryDetailsView(_id)),
                  color: Theme.of(_context!).errorColor),
              IconButton(
                  key: Key('$K_INV_DEL_BTN$_id'),
                  icon: _icons.icon_delete(),
                  // @formatter:off
                  onPressed: () =>
                      _inventoryController.deleteProduct(_id).then((statusCode) {
                        if (statusCode >= 200 && statusCode < 400) {
                          _inventoryController.updateInventoryProductsObs();
                          _overviewController.deleteProduct(_id);
                          _overviewController.updateFilteredProductsObs();
                          SimpleSnackbar().show(_words.suces(), _messages
                              .suces_inv_prod_del());
                        }
                        if (statusCode >= 400) {
                          SimpleSnackbar().show(_words.ops(), _messages.error_inv_prod());
                        }
                      }),
                  // @formatter:on
                  color: Theme.of(_context).errorColor),
            ])));
  }
}