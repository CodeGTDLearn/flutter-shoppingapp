import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../modules/cart/controller/cart_controller.dart';
import '../../../modules/inventory/controller/inventory_controller.dart';
import '../../../modules/orders/controller/orders_controller.dart';
import '../../local_storage/local_storage_controller.dart';
import '../../routes/core_routes.dart';
import '../../texts/core_labels.dart';
import '../../texts/core_messages.dart';
import '../core_components_icons.dart';
import '../core_components_keys.dart';
import '../snackbar/core_snackbar.dart';
import 'core_drawer_labels.dart';

// ignore: must_be_immutable
class CoreDrawer extends StatelessWidget {
  final _cart = Get.find<CartController>();
  final _icons = Get.find<CoreComponentsIcons>();
  final _messages = Get.find<CoreMessages>();
  final _words = Get.find<CoreLabels>();
  final _labels = Get.find<CoreDrawerLabels>();
  final _orders = Get.find<OrdersController>();
  final _inventory = Get.find<InventoryController>();
  final _keys = Get.find<CoreComponentsKeys>();
  final _storage = Get.find<LocalStorageController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70,
      child: Drawer(
          child: Column(children: [
        AppBar(title: Text(_labels.label_appbar), automaticallyImplyLeading: false),
        _drawerItem(
            // quantityItems: _cart.qtdeCartItems(),
            quantityItems: _cart.qtdeCartItemsObs.value,
            leadIcon: _icons.ico_cart(),
            title: _labels.label_cart,
            message: _messages.cart_no_items_yet,
            route: CoreRoutes.CART,
            notRoutingWithoutQtdeEvaluation: true,
            key: _keys.k_drw_cart_opt2(),
            context: context),
        _drawerItem(
            quantityItems: _orders.qtdeOrdersObs.value,
            leadIcon: _icons.ico_ord(),
            title: _labels.label_orders,
            message: _messages.no_orders_yet,
            route: CoreRoutes.ORDERS,
            notRoutingWithoutQtdeEvaluation: false,
            key: _keys.k_drw_orders_opt3(),
            context: context),
        _drawerItem(
            quantityItems: _inventory.getProductsQtde(),
            leadIcon: _icons.ico_inv(),
            title: _labels.label_inventory,
            message: _messages.no_products_yet,
            route: CoreRoutes.INVENTORY,
            notRoutingWithoutQtdeEvaluation: false,
            key: _keys.k_drw_inventory_opt4(),
            context: context),
        // _drawerItem(
        //     quantityItems: _inventory.getProductsQtde(),
        //     leadIcon: _icons.ico_warehouse(),
        //     title: _labels.label_warehouse,
        //     message: _messages.no_warehouses_found,
        //     route: CoreRoutes.WAREHOUSE,
        //     notRoutingWithoutQtdeEvaluation: false,
        //     key: _keys.k_drw_warehouse_opt5(),
        //     context: context),
        Obx(() => SwitchListTile(
            key: Key(_keys.k_drw_darkthm_opt5()),
            secondary: _icons.ico_switch(),
            title: Text(_labels.label_dark_theme),
            subtitle: Text(_labels.label_content_dark_theme),
            value: _storage.darkModelObs.value,
            onChanged: (_) => _storage.switchTheme()))
      ])),
    );
  }

  ListTile _drawerItem({
    required int quantityItems,
    required Icon leadIcon,
    required String title,
    required String message,
    required String route,
    required bool notRoutingWithoutQtdeEvaluation,
    required String key,
    required BuildContext context,
  }) {
    // @formatter:off
    return ListTile(
        key: Key(key),
        leading: leadIcon,
        title: Text(title),
        onTap: () {
          Navigator.pop(context);
          var condition1 = quantityItems == 0 && notRoutingWithoutQtdeEvaluation;
          var condition2 = quantityItems != 0 && notRoutingWithoutQtdeEvaluation;
          if (condition1) {
            CoreSnackbar().show(_words.suces(), message);
          } else if (condition2) {
            Get.toNamed(route);
          } else {
            Get.toNamed(route);
          }
        });
    // @formatter:on
  }
}