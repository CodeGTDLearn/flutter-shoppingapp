import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_properties.dart';
import 'package:shopingapp/app/config/app_routes.dart';
import 'package:shopingapp/app/config/messages/flush_notifier.dart';
import 'package:shopingapp/app/config/titles_icons/app_core.dart';
import 'package:shopingapp/app/config/titles_icons/components/drawwer.dart';
import 'package:shopingapp/app/modules/cart/cart_controller.dart';
import 'package:shopingapp/app/modules/core/app_theme/app_theme_store.dart';
import 'package:shopingapp/app/modules/managed_products/managed_products_controller.dart';
import 'package:shopingapp/app/modules/orders/orders_controller.dart';

import 'flush_notifier.dart';

class Drawwer extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    final _theme = Modular.get<AppThemeStoreBase>();
    final _cart = Modular.get<CartControllerBase>();
    final _orders = Modular.get<OrdersControllerBase>();
    final _manProd = Modular.get<ManagedProductsControllerBase>();

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
      _drawerItem(_cart.qtdeCartItems, DRAWER_ICO_SHOP, DRAWER_LBL_SHOP,
          FLUSHNOTIF_MSG_CART_EMPTY, CART_ROUTE, false),
      _drawerItem(_orders.qtdeOrders, DRAWER_ICO_PAY, DRAWER_LBL_PAY,
          FLUSHNOTIF_MSG_NOORDER, ORDERS_ROUTE, false),
      _drawerItem(_manProd.qtdeManagedProducts, DRAWER_ICO_MAN, DRAWER_LBL_MAN,
          FLUSHNOTIF_MSG_NOMANPRODUCT, MANAGPRODUCT_ROUTE, true),
      Observer(
          builder: (BuildContext _) => SwitchListTile(
              secondary: DRAWER_ICO_DARK,
              title: Text(DRAWER_LBL_DARK),
              value: _theme.isDark,
              onChanged: (value) => _theme.toggleDarkTheme(value)))
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
            FlushNotifier(OPS, message, INTERVAL, this._context).simple();
          } else if (!noConditional && qtde != 0) {
            Modular.to.pushNamed(route);
          } else if (noConditional) {
            Modular.to.pushNamed(route);
          }
        });
  }
}
