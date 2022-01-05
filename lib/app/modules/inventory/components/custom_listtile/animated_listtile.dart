import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../../core/custom_widgets/snackbar/simple_snackbar.dart';
import '../../../../core/icons/modules/inventory/inventory_icons.dart';
import '../../../../core/keys/modules/inventory_keys.dart';
import '../../../../core/properties/app_properties.dart';
import '../../../../core/texts/general_words.dart';
import '../../../../core/texts/messages.dart';
import '../../../../core/utils/animations_utils.dart';
import '../../../overview/controller/overview_controller.dart';
import '../../controller/inventory_controller.dart';
import '../../entity/product.dart';
import '../../view/inventory_details_view.dart';
import '../../view/inventory_image_view.dart';
import 'icustom_listtile.dart';

class AnimatedListTile implements ICustomListTile {
  final _icons = Get.find<InventoryIcons>();
  final _inventoryController = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();
  final _animations = Get.find<AnimationsUtils>();
  final _messages = Get.find<Messages>();
  final _words = Get.find<GeneralWords>();

  @override
  Widget customListTile(Product _product) {
    var _id = _product.id!;

    return OpenContainer(
      transitionDuration: Duration(milliseconds: DELAY_MILLISEC_LISTTILE),
      transitionType: ContainerTransitionType.fadeThrough,
      openBuilder: (context, void Function({Object? returnValue}) openContainer) {
        return InventoryDetailsView(_id);
      },
      closedBuilder: (context, void Function() openContainer) {
        return ListTile(
            key: Key('$K_INV_ITEM_KEY$_id'),
            leading: _animations.openContainer(
                openingWidget: InventoryImageView(_product.title, _product.imageUrl),
                closingWidget:
                    CircleAvatar(backgroundImage: NetworkImage(_product.imageUrl))),
            title: Text(_product.title),
            trailing: Container(
                width: 100,
                child: Row(children: <Widget>[
                  IconButton(
                      key: Key('$K_INV_UPD_BTN$_id'),
                      icon: _icons.icon_update(),
                      onPressed: openContainer,
                      color: Theme.of(context).errorColor),
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
                              SimpleSnackbar().show(_words.ops(), _messages
                                  .error_inv_prod());
                            }
                          }),
                      // @formatter:on
                      color: Theme.of(context).errorColor),
                ])));
      },
    );
  }
}