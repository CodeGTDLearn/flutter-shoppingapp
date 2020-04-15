import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/service_stores/CartStore.dart';
import 'package:shopingapp/service_stores/OrdersStore.dart';
import 'package:shopingapp/widgets/flushNotifier.dart';

class Drawwer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cartStore = Modular.get<ICartStore>();
    final _ordersStore = Modular.get<IOrdersStore>();
    return Drawer(
        child: Column(children: [
          AppBar(title: Text(DRW_TXT_APPBAR), automaticallyImplyLeading: false),
          Divider(),
          drawwerListTile(
              _cartStore.totalQtdeCartItems, context, DRW_ICO_SHOP,
              DRW_TITLE_SHOP, FLBAR_MSG_CARTEMPTY, ROUTE_CART),
          Divider(),
          drawwerListTile(_ordersStore.totalOrders, context,
              DRW_ICO_PAY, DRW_TITLE_PAY, FLBAR_MSG_NOORDER, ROUTE_ORDERS)
        ]));
  }

  ListTile drawwerListTile(int qtde, BuildContext context, Icon leadIcon,
      String title, String flushMessage, String route) {
    return ListTile(
        leading: leadIcon,
        title: Text(title),
        onTap: () {
          if (qtde == 0) {
            FlushNotifier(FLBAR_TIT_OPS, flushMessage, FLBAR_TIME, context)
                .show();
          } else {
            Modular.to.pushNamed(ROUTE_ORDERS);
          }
        });
  }
}

