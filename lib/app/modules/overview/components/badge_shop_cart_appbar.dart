import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_properties.dart';
import 'package:shopingapp/app/config/app_routes.dart';
import 'package:shopingapp/app/config/messages/field_validation.dart';
import 'package:shopingapp/app/config/titles_icons/app_core.dart';
import 'package:shopingapp/app/config/titles_icons/views/overview.dart';
import 'package:shopingapp/app/modules/cart/cart_controller.dart';
import 'package:shopingapp/app/modules/core/components/flush_notifier.dart';

class BadgeShopCartAppbar extends StatelessWidget {
  final Widget child;
  final String value;
  final Color color;

  const BadgeShopCartAppbar({Key key, this.child, this.value, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cartStore = Modular.get<CartControllerBase>();
    return Observer(
        builder: (BuildContext _) =>
            Stack(alignment: Alignment.center, children: [
              IconButton(
                  icon: OVERVIEW_ICO_SHOP,
                  onPressed: () {
                    if (_cartStore.qtdeCartItems == 0) {
                      FlushNotifier(OPS, MSG_VALID_EMPTY, INTERVAL, context)
                          .simple();
                    } else {
                      //Navigator.pushNamed(context, CART_ROUTE);
                      Modular.to.pushNamed(CART_ROUTE);
                    }
                  }),
              Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                      padding: EdgeInsets.all(2.0),
                      // color: Theme.of(context).accentColor,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: color != null
                              ? color
                              : Theme.of(context).accentColor),
                      constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(_cartStore.qtdeCartItems.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10))))
            ]));
  }
}
