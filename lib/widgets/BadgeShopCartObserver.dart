import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/service_stores/CartStore.dart';
import 'package:shopingapp/widgets/flushNotifier.dart';

class BadgeShopCartObserver extends StatelessWidget {
  const BadgeShopCartObserver({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final _servCartStore = Modular.get<ICartStore>();
    return Observer(
        builder: (BuildContext _) => Stack(alignment: Alignment.center, children: [
              IconButton(
                  icon: IOS_ICO_SHOP,
                  onPressed: () {
                    if (_servCartStore.totalCartItems == "0") {
                      FlushNotifier(FLBAR_TIT_CARTEMPTY, FLBAR_MSG_CARTEMPTY, FLBAR_TIME, context)
                          .show();
                    } else {
                      Navigator.pushNamed(context, ROUTE_CART);
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
                      child: Text(_servCartStore.totalCartItems,
                          textAlign: TextAlign.center, style: TextStyle(fontSize: 10))))
            ]));
  }
}
