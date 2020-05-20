import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../config/titlesIconsMessages/general.dart';
import '../config/appProperties.dart';
import '../config/titlesIconsMessages/views/itemOverviewView.dart';
import '../config/titlesIconsMessages/widgets/flushNotifier.dart';
import '../service_stores/cartStore.dart';
import '../widgets/flushNotifier.dart';

class AppbarBadgeShopCart extends StatelessWidget {
  final Widget child;
  final String value;
  final Color color;

  const AppbarBadgeShopCart({Key key, this.child, this.value, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cartStore = Modular.get<CartStoreInt>();
    return Observer(
        builder: (BuildContext _) => Stack(alignment: Alignment.center, children: [
              IconButton(
                  icon: IOV_ICO_SHOP,
                  onPressed: () {
                    if (_cartStore.qtdeCartItems == 0) {
                      FlushNotifier(OPS, MSG_CARTEMPT, FLSH_TIME, context).simple();
                    } else {
                      Navigator.pushNamed(context, CART_VIEW);
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
                          color: color != null ? color : Theme.of(context).accentColor),
                      constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(_cartStore.qtdeCartItems.toString(),
                          textAlign: TextAlign.center, style: TextStyle(fontSize: 10))))
            ]));
  }
}
