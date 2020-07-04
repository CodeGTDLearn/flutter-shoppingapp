import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../../../config/app_properties.dart';
import '../../../config/app_routes.dart';
import '../../../config/messages/flush_notifier.dart';
import '../../../config/titles_icons/app_core.dart';
import '../../../config/titles_icons/components/drawwer.dart';
import '../../../modules/core/app_theme/dark_theme_store.dart';
import '../../cart/service/cart_service.dart';
import '../../cart/service/i_cart_service.dart';
import '../../managed_products/services/i_managed_products_service.dart';
import '../../managed_products/services/managed_products_service.dart';
import '../../orders/service/i_orders_service.dart';
import '../../orders/service/orders_service.dart';
import 'flush_notifier.dart';

// ignore: must_be_immutable
class Drawwer extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    var _theme = Get.put(DarkThemeStore());

    final ICartService _cart = Get.put(CartService());

    final IOrdersService _orders = Get.put(OrdersService());

    final IManagedProductsService _manProd = Get.put(ManagedProductsService());

    return Drawer(
        child: Column(children: [
      AppBar(title: Text(DRAWER_LBL_APPBAR), automaticallyImplyLeading: false),
      _drawerItem(
          _manProd.getAll().length,
          DRAWER_ICO_PRODUCTS,
          DRAWER_LBL_PRODUCTS,
          FLUSHNOTIF_MSG_PRODUCTS,
          Modular.initialRoute,
          false),
      _drawerItem(_cart.cartItemsQtde(), DRAWER_ICO_SHOP, DRAWER_LBL_SHOP,
          FLUSHNOTIF_MSG_CART_EMPTY, CART_ROUTE, false),
      _drawerItem(_orders.ordersQtde(), DRAWER_ICO_PAY, DRAWER_LBL_PAY,
          FLUSHNOTIF_MSG_NOORDER, ORDERS_ROUTE, false),
      _drawerItem(_manProd.managedProductsQtde(), DRAWER_ICO_MAN,
          DRAWER_LBL_MAN, FLUSHNOTIF_MSG_NOMANPRODUCT, MAN_PROD_ROUTE, true),
      SwitchListTile(
          secondary: DRAWER_ICO_DARK,
          title: Text(DRAWER_LBL_DARK),
          value: _theme.isDark,
          onChanged: _theme.toggleDarkTheme)
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
