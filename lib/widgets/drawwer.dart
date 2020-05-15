import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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

    final _cartStore = Modular.get<CartStoreInt>();
    final _ordersStore = Modular.get<OrdersStoreInt>();
    return Drawer(
        child: Column(children: [
      AppBar(title: Text(DRW_TXT_APPBAR), automaticallyImplyLeading: false),
      Divider(),
      _drawwerListTile(
          _cartStore.totalQtdeCartItems, DRW_ICO_SHOP, DRW_TIT_SHOP, MSG_CARTEMPTY, RT_CART_VIEW),
      Divider(),
      _drawwerListTile(
          _ordersStore.totalOrders, DRW_ICO_PAY, DRW_TIT_PAY, MSG_NOORDER, RT_ORDERS_VIEW)
    ]));
  }

  ListTile _drawwerListTile(
    int qtde,
    Icon leadIcon,
    String title,
    String flushMessage,
    String route,
  ) {
    return ListTile(
        leading: leadIcon,
        title: Text(title),
        onTap: () {
          if (qtde == 0) {
            FlushNotifier(OPSS, flushMessage, FLSH_TIME, this._context).simple();
          } else {
            Modular.to.pushNamed(route);
          }
        });
  }
}
