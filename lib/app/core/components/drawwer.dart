import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/cart/service/i_cart_service.dart';
import '../../modules/inventory/controller/inventory_controller.dart';
import '../../modules/orders/service/i_orders_service.dart';
import '../properties/app_routes.dart';
import '../properties/theme/dark_theme_controller.dart';
import '../texts_icons_provider/generic_words.dart';
import 'app_messages_provided.dart';
import 'keys/drawwer_keys.dart';
import 'snackbarr.dart';
import 'texts_icons/drawwer_texts_icons_provided.dart';

// ignore: must_be_immutable
class Drawwer extends StatelessWidget {
  BuildContext _context;
  final ICartService _cart = Get.find();
  final IOrdersService _orders = Get.find();
  final InventoryController _managedProducts = Get.find();
  final DarkThemeController _darkThemeController = Get.find();

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Drawer(
        child: Column(children: [
      AppBar(title: Text(DRW_TIT_APPBAR), automaticallyImplyLeading: false),
      _drawerItem(
          quantityItems: _managedProducts.managedProductsQtde(),
          leadIcon: DRW_ICO_PROD,
          title: DRW_LBL_PROD,
          message: DRW_NO_DATA,
          route: AppRoutes.OVERVIEW_ALL,
          notRoutingWithoutQtdeEvaluation: false,
          key: K_DRW_OV_OP1),
      _drawerItem(
          quantityItems: _cart.cartItemsQtde(),
          leadIcon: DRW_ICO_CART,
          title: DRW_LBL_CART,
          message: DRW_TXT_CART,
          route: AppRoutes.CART,
          notRoutingWithoutQtdeEvaluation: true,
          key: K_DRW_CRT_OP2),
      _drawerItem(
          quantityItems: _orders.ordersQtde(),
          leadIcon: DRW_ICO_ORD,
          title: DRW_LBL_ORD,
          message: DRW_TXT_ORD,
          route: AppRoutes.ORDERS,
          notRoutingWithoutQtdeEvaluation: false,
          key: K_DRW_ORD_OP3),
      _drawerItem(
          quantityItems: _managedProducts.managedProductsQtde(),
          leadIcon: DRW_ICO_MAN_PROD,
          title: DRW_LBL_MAN_PROD,
          message: DRW_TXT_NO_MAN_PROD_YET,
          route: AppRoutes.MANAGED_PRODUCTS,
          notRoutingWithoutQtdeEvaluation: false,
          key: K_DRW_MPROD_OP4),
      Obx(() => SwitchListTile(
          key: Key(K_DRW_DARKM_OP5),
          secondary: DRW_ICO_DARKTHM,
          title: Text(DRW_LBL_DARKTHM),
          value: _darkThemeController.isDark.value,
          onChanged: _darkThemeController.toggleDarkTheme))
    ]));
  }

  ListTile _drawerItem(
      {int quantityItems,
      Icon leadIcon,
      String title,
      String message,
      String route,
      bool notRoutingWithoutQtdeEvaluation,
      String key}) {
    return ListTile(
        key: Key(key),
        leading: leadIcon,
        title: Text(title),
        onTap: () {
          Navigator.pop(_context);
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
