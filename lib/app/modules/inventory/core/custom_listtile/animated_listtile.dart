import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/inventory_keys.dart';
import '../../../../core/properties/app_properties.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/inventory/inventory_item_icons_provided.dart';
import '../../../../core/texts_icons_provider/pages/inventory/messages_snackbars_provided.dart';
import '../../../../core/utils/animations_utils.dart';
import '../../../overview/controller/overview_controller.dart';
import '../../controller/inventory_controller.dart';
import '../../entity/product.dart';
import '../../view/inventory_item_details_view.dart';
import '../../view/inventory_item_image_view.dart';
import 'icustom_listtile.dart';

class AnimatedListTile implements ICustomListTile {
  final _inventoryController = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();
  final _animations = Get.find<AnimationsUtils>();

  @override
  Widget create(Product _product) {
    var _id = _product.id!;

    return OpenContainer(
      transitionDuration: Duration(milliseconds: DELAY_MILLISEC_LISTTILE),
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (context, void Function({Object? returnValue}) openContainer) {
        return InventoryItemDetailsView(_id);
      },
      closedBuilder: (context, void Function() openContainer) {
        return ListTile(
            key: Key('$K_INV_ITEM_KEY$_id'),
            leading: _animations.openContainer(
                openingWidget: InventoryItemImageView(_product.title, _product.imageUrl),
                closingWidget:
                    CircleAvatar(backgroundImage: NetworkImage(_product.imageUrl))),
            title: Text(_product.title),
            trailing: Container(
                width: 100,
                child: Row(children: <Widget>[
                  IconButton(
                      key: Key('$K_INV_UPD_BTN$_id'),
                      icon: INV_ITEM_UPD_ICO,
                      onPressed: openContainer,
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
                              SimpleSnackbar().show(SUCES, SUCESS_MAN_PROD_DEL);
                            }
                            if (statusCode >= 400) {
                              SimpleSnackbar().show(OPS, ERROR_MAN_PROD);
                            }
                          }),
                      // @formatter:on
                      color: Theme.of(context).errorColor),
                ])));
      },
    );
  }
}