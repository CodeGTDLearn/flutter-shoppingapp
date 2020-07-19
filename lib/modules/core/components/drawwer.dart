import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../cart/service/i_cart_service.dart';
import '../../managed_products/services/i_managed_products_service.dart';
import '../../orders/service/i_orders_service.dart';
import '../app_routes.dart';
import '../configurable/app_properties.dart';
import '../configurable/textual_interaction/messages/flush_notifier.dart';
import '../configurable/textual_interaction/titles_icons/app_core.dart';
import '../configurable/textual_interaction/titles_icons/components/drawwer.dart';
import '../configurable/theme/dark_theme_controller.dart';
import 'flush_notifier.dart';

// ignore: must_be_immutable
class Drawwer extends StatelessWidget {
  BuildContext _context;
  final ICartService _cart = Get.find();
  final IOrdersService _orders = Get.find();
  final IManagedProductsService _manProd = Get.find();
  final DarkThemeController _darkThemeController = Get.find();

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Drawer(
        child: Column(children: [
      AppBar(title: Text(DRAWER_LBL_APPBAR), automaticallyImplyLeading: false),
      _drawerItem(
          _manProd.managedProductsQtde(),
          DRAWER_ICO_PRODUCTS,
          DRAWER_LBL_PRODUCTS,
          FLUSHNOTIF_MSG_PRODUCTS,
          AppRoutes.OVERVIEW_ALL_ROUTE,
          false),
      _drawerItem(
        _cart.cartItemsQtde(),
        DRAWER_ICO_SHOP,
        DRAWER_LBL_SHOP,
        FLUSHNOTIF_MSG_CART_EMPTY,
        AppRoutes.CART_ROUTE,
        false,
      ),
      _drawerItem(
        _orders.ordersQtde(),
        DRAWER_ICO_PAY,
        DRAWER_LBL_PAY,
        FLUSHNOTIF_MSG_NOORDER,
        AppRoutes.ORDERS_ROUTE,
        false,
      ),
      _drawerItem(
        _manProd.managedProductsQtde(),
        DRAWER_ICO_MAN,
        DRAWER_LBL_MAN,
        FLUSHNOTIF_MSG_NOMANPRODUCT,
        AppRoutes.MAN_PROD_ROUTE,
        true,
      ),
      Obx(() => SwitchListTile(
          secondary: DRAWER_ICO_DARK,
          title: Text(DRAWER_LBL_DARK),
          value: _darkThemeController.isDark.value,
          onChanged: _darkThemeController.toggleDarkTheme))
    ]));
  }

  ListTile _drawerItem(
    int qtde,
    Icon leadIcon,
    String title,
    String message,
    String route,
    bool noConditional,
  ) {
    return ListTile(
        leading: leadIcon,
        title: Text(title),
        onTap: () {
          if (!noConditional && qtde == 0) {
            FlushNotifier(OPS, message, INTERVAL, _context).simple();
          } else if (!noConditional && qtde != 0) {
            Get.toNamed(route);
          } else if (noConditional) {
            Get.toNamed(route);
          }
        });
  }
}
