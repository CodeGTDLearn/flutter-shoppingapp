import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/cart/service/i_cart_service.dart';
import '../../modules/inventory/controller/inventory_controller.dart';
import '../../modules/orders/service/i_orders_service.dart';
import '../properties/app_routes.dart';
import '../properties/theme/app_theme_controller.dart';
import '../texts_icons_provider/generic_words.dart';
import 'app_messages_provided.dart';
import 'keys/drawwer_keys.dart';
import 'snackbar/simple_snackbar.dart';
import 'texts_icons/drawwer_texts_icons_provided.dart';

// ignore: must_be_immutable
class Drawwer extends StatelessWidget {
  final ICartService _cart = Get.find();
  final IOrdersService _orders = Get.find();
  final InventoryController _inventory = Get.find();
  final AppThemeController _darkThemeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      AppBar(title: Text(DRW_TIT_APPBAR), automaticallyImplyLeading: false),
      _drawerItem(
          quantityItems: _inventory.getProductsQtde(),
          leadIcon: DRW_ICO_PROD,
          title: DRW_LBL_PROD,
          message: DRW_NO_DATA,
          route: AppRoutes.OVERVIEW_ALL,
          notRoutingWithoutQtdeEvaluation: false,
          key: K_DRW_OV_OP1,
          context: context),
      _drawerItem(
          quantityItems: _cart.cartItemsQtde(),
          leadIcon: DRW_ICO_CART,
          title: DRW_LBL_CART,
          message: DRW_TXT_CART,
          route: AppRoutes.CART,
          notRoutingWithoutQtdeEvaluation: true,
          key: K_DRW_CRT_OP2,
          context: context),
      _drawerItem(
          quantityItems: _orders.ordersQtde(),
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
    ]));
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
    return ListTile(
        key: Key(key),
        leading: leadIcon,
        title: Text(title),
        onTap: () {
          Navigator.pop(context);
          if (quantityItems == 0 && notRoutingWithoutQtdeEvaluation) {
            SimpleSnackbar(SUCES, message).show();
          } else if (quantityItems != 0 && notRoutingWithoutQtdeEvaluation) {
            Get.toNamed(route);
          } else {
            Get.toNamed(route);
          }
        });
  }
}
