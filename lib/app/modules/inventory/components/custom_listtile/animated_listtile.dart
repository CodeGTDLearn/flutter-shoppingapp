import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../../core/global_widgets/custom_alert_dialog.dart';
import '../../../../core/global_widgets/snackbar/simple_snackbar.dart';
import '../../../../core/icons/modules/inventory_icons.dart';
import '../../../../core/keys/modules/inventory_keys.dart';
import '../../../../core/labels/global_labels.dart';
import '../../../../core/labels/message_labels.dart';
import '../../../../core/labels/modules/inventory_labels.dart';
import '../../../../core/properties/properties.dart';
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
  final _messages = Get.find<MessageLabels>();
  final _words = Get.find<GlobalLabels>();
  final _keys = Get.find<InventoryKeys>();
  final _labels = Get.find<InventoryLabels>();

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
            key: Key('${_keys.k_inv_item_key()}$_id'),
            leading: _openInventoryImageViewProduct(_product),
            title: Text(_product.title),
            trailing: Container(
                width: 100,
                child: Row(children: <Widget>[
                  _updateIconButton(_id, openContainer, context),
                  _deleteIconButton(_id, context, _product),
                ])));
      },
    );
  }

  OpenContainer<Object> _openInventoryImageViewProduct(Product _product) {
    return _animations.openContainer(
              openingWidget: InventoryImageView(_product.title, _product.imageUrl),
              closingWidget:
                  CircleAvatar(backgroundImage: NetworkImage(_product.imageUrl)));
  }

  IconButton _deleteIconButton(String _id, BuildContext context, Product _product) {
    return IconButton(
                    key: Key('${_keys.k_inv_del_btn()}$_id'),
                    icon: _icons.icon_delete(),
                    // @formatter:off
                    onPressed: ()
                        {
                            CustomAlertDialog.showOptionDialog(
                            context,
                            _labels.INV_EDT_DEL_CONF_TIT(),
                            '${_labels.INV_EDT_DEL_CONF_MESSAGE()}${_product.title}',
                            _words.yes(),
                            _words.no(),
                            () => _deleteItemConfirmed(_id),
                            () => {},
                            );
                        },
                    // @formatter:on
                    color: Theme.of(context).errorColor);
  }

  IconButton _updateIconButton(String _id, void openContainer(), BuildContext context) {
    return IconButton(
                    key: Key('${_keys.k_inv_upd_btn()}$_id'),
                    icon: _icons.icon_update(),
                    onPressed: openContainer,
                    color: Theme.of(context).errorColor);
  }

  Future<Null> _deleteItemConfirmed(String _id) {
    return _inventoryController.deleteProduct(_id).then((statusCode) {
      if (statusCode >= 200 && statusCode < 400) {
        _inventoryController.updateInventoryProductsObs();
        _overviewController.deleteProduct(_id);
        _overviewController.updateFilteredProductsObs();
        SimpleSnackbar().show(_words.suces(), _messages.suces_inv_prod_del());
      }
      if (statusCode >= 400) {
        SimpleSnackbar().show(_words.ops(), _messages.error_inv_prod());
      }
    });
  }
}