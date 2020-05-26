import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/routes.dart';

import 'package:shopingapp/service_stores/managedProductsStore.dart';
import '../config/titlesIconsMessages/general.dart';
import '../config/appProperties.dart';
import '../config/titlesIconsMessages/widgets/drawwer.dart';
import '../config/titlesIconsMessages/widgets/flushNotifier.dart';
import '../service_stores/cartStore.dart';
import '../service_stores/ordersStore.dart';
import '../widgets/flushNotifier.dart';

class Drawwer extends StatelessWidget {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;

    final _cart = Modular.get<CartStoreInt>();
    final _orders = Modular.get<OrdersStoreInt>();
    final _manProd = Modular.get<ManagedProductsStoreInt>();

    return Drawer(
        child: Column(children: [
      AppBar(title: Text(DRW_TXT_APPBAR), automaticallyImplyLeading: false),
      _drawerItem(_cart.qtdeCartItems, DRW_ICO_SHOP, DRW_LBL_SHOP, MSG_CARTEMPT, CART_VIEW, false),
      _drawerItem(_orders.qtdeOrders, DRW_ICO_PAY, DRW_LBL_PAY, MSG_NOORDER, ORDERS_VIEW, false),
      _drawerItem(_manProd.qtdeManagedProducts, DRW_ICO_MAN, DRW_LBL_MAN, MSG_NOMANPRODUCT,
          MANAGEDPRODUCT_VIEW, true)
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
            FlushNotifier(OPS, message, FLSH_TIME, this._context).simple();
          } else if (!noConditional && qtde != 0) {
            Modular.to.pushNamed(route);
          } else if (noConditional) {
            Modular.to.pushNamed(route);
          }
        });
  }
}
