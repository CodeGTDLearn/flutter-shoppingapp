import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_monitor_builds.dart';
import 'package:shopingapp/app/config/titles_icons/views/cart.dart';
import 'package:shopingapp/app/modules/orders/orders_controller.dart';

import 'cart_controller.dart';
import 'components/card_cart_item.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CartController> {
//  final _cartStore = Modular.get<CartController>();
  final _orderStore = Modular.get<OrdersController>();

  @override
  void initState() {
//    _cartStore.calcAmount$CartItems();
    controller.calcAmount$CartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_VIEW_CART);
    return Scaffold(
        appBar: AppBar(title: Text(CART_APPBAR_TIT), actions: <Widget>[
          IconButton(
              icon: CART_ICO_CLEARALL,
//              onPressed: () => _cartStore.clearCart(),
              onPressed: () => controller.clearCart(),
              tooltip: CART_ICO_CLEARALL_TOLTIP)
        ]),
        body: Column(children: [
          Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: <Widget>[
                    Text(CART_LBL_CARD, style: TextStyle(fontSize: 20)),
                    Spacer(),
                    Chip(
                        label: Observer(
                            builder: (BuildContext _) => Text(
//                                _cartStore.amountCartItems.toStringAsFixed(2),
                                controller.amountCartItems.toStringAsFixed(2),
                                style: TextStyle(color: Colors.white))),
                        backgroundColor: Theme.of(context).primaryColor),
                    FlatButton(
                        onPressed: () {
                          _orderStore.addOrder(
//                            _cartStore.getAll().values.toList(),
                            controller.getAll().values.toList(),
//                            _cartStore.amountCartItems,
                            controller.amountCartItems,
                          );
//                          _cartStore.clearCart();
                          controller.clearCart();
                        },
                        child: Text(CART_LBL_ORDER,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)))
                  ]))),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
//                  itemCount: _cartStore.getAll().length,
                  itemCount: controller.getAll().length,
                  itemBuilder: (ctx, item) {
                    print(MON_BUILD_COMP_CARTVIEW_LISTVIEWBUILDER_CARTCARDITEM);
                    return CardCartItem(
//                        _cartStore.getAll().values.elementAt(item));
                        controller.getAll().values.elementAt(item));
                  }))
        ]));
  }
}
