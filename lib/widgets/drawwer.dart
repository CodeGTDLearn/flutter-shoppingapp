import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/service_stores/CartStore.dart';
import 'package:shopingapp/service_stores/OrdersStore.dart';
import 'package:shopingapp/widgets/flushNotifier.dart';

class Drawwer extends StatelessWidget {
  BuildContext _context = null;

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
          _cartStore.totalQtdeCartItems, DRW_ICO_SHOP, DRW_TIT_SHOP, MSG_CARTEMPTY, RT_CART),
      Divider(),
      _drawwerListTile(
          _ordersStore.totalOrders, DRW_ICO_PAY, DRW_TIT_PAY, MSG_NOORDER, RT_ORDERS)
    ]));
  }

  ListTile _drawwerListTile(
      int qtde, Icon leadIcon, String title, String flushMessage, String route) {
    return ListTile(
        leading: leadIcon,
        title: Text(title),
        onTap: () {
          if (qtde == 0) {
            FlushNotifier(OPS, flushMessage, FLSBR_TIME, this._context).simple();
          } else {
            Modular.to.pushNamed(route);
          }
        });
  }
}
