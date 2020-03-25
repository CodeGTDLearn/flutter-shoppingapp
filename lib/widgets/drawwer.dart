import 'package:flutter/material.dart';
import 'package:shopingapp/config/titlesIcons.dart';

class Drawwer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(title: Text(DRW_TXT_APPBAR), automaticallyImplyLeading: false),
        Divider(),
        ListTile(
            leading: DRW_ICO_SHOP,
            title: Text(DRW_TITLE_SHOP),
            onTap: () {
//              Navigator.of(context)
//                  .pushReplacementNamed(Routes().screenOverview);
//              Navigator.pushNamed(context, ROUTE_CART);
//              Modular.to.pushReplacementNamed('/login');
            }),
        Divider(),
        ListTile(
            leading: DRW_ICO_PAY,
            title: Text(DRW_TITLE_PAY),
            onTap: () {
//              Navigator.of(context).pushReplacementNamed(Routes().screenOrders);
            })
      ]),
    );
  }
}
