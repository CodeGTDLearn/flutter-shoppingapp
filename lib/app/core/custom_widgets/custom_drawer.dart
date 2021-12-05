import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../modules/cart/controller/cart_controller.dart';
import '../../modules/inventory/controller/inventory_controller.dart';
import '../../modules/orders/controller/orders_controller.dart';
import '../keys/components/custom_drawer_keys.dart';
import '../properties/app_routes.dart';
import '../properties/theme/app_theme_controller.dart';
import '../texts_icons_provider/generic_words.dart';
import '../texts_icons_provider/pages/components/drawwer_texts_icons_provided.dart';
import 'custom_snackbar/simple_snackbar.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  final _cart = Get.find<CartController>();
  final _orders = Get.find<OrdersController>();
  final _inventory = Get.find<InventoryController>();

  // final _overview = Get.find<OverviewController>();
  final _darkThemeController = Get.find<AppThemeController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70,
      child: Drawer(
          child: Column(children: [
        AppBar(title: Text(DRW_TIT_APPBAR), automaticallyImplyLeading: false),
        // _drawerItem(
        //     quantityItems: _overview.getProductsQtde(),
        //     leadIcon: DRW_ICO_PROD,
        //     title: DRW_LBL_PROD,
        //     message: DRW_NO_DATA,
        //     route: AppRoutes.OVERVIEW_ALL,
        //     notRoutingWithoutQtdeEvaluation: false,
        //     key: K_DRW_OV_OP1,
        //     context: context),
        _drawerItem(
            // quantityItems: _cart.qtdeCartItems(),
            quantityItems: _cart.getQtdeCartItemsObs(),
            leadIcon: DRW_ICO_CART,
            title: DRW_LBL_CART,
            message: DRW_TXT_CART,
            route: AppRoutes.CART,
            notRoutingWithoutQtdeEvaluation: true,
            key: K_DRW_CRT_OP2,
            context: context),
        _drawerItem(
            quantityItems: _orders.getQtdeOrdersObs(),
            leadIcon: DRW_ICO_ORD,
            title: DRW_LBL_ORD,
            message: DRW_TXT_ORD,
            route: AppRoutes.ORDERS,
            notRoutingWithoutQtdeEvaluation: false,
            key: K_DRW_ORD_OP3,
            context: context),
        _drawerItem(
            quantityItems: _inventory.getProductsQtde(),
            leadIcon: DRW_ICO_MAN_PROD,
            title: DRW_LBL_MAN_PROD,
            message: DRW_TXT_NO_MAN_PROD_YET,
            route: AppRoutes.INVENTORY,
            notRoutingWithoutQtdeEvaluation: false,
            key: K_DRW_MPROD_OP4,
            context: context),
        Obx(() => SwitchListTile(
            key: Key(K_DRW_DARKM_OP5),
            secondary: DRW_ICO_DARKTHM,
            title: Text(DRW_LBL_DARKTHM),
            value: _darkThemeController.isDark.value,
            onChanged: _darkThemeController.toggleDarkTheme))
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
            SimpleSnackbar().show(SUCES, message);
          } else if (condition2) {
            Get.toNamed(route);
          } else {
            Get.toNamed(route);
          }
        });
    // @formatter:on
  }
}