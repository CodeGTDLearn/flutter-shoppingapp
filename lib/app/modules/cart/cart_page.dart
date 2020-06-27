import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './../../config/app_monitor_builds.dart';
import './../../config/titles_icons/views/cart.dart';
import 'cart_controller.dart';
import 'components/card_cart_item.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ModularState<CartPage, CartController> {
  @override
  void initState() {
    controller.recalcQtdeAndAmountCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_PAGE_CART);
    return Scaffold(
        appBar: AppBar(title: Text(CART_APPBAR_TIT), actions: <Widget>[
          IconButton(
              icon: CART_ICO_CLEARALL,
              onPressed: controller.clearCart,
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
                            builder: (_) => Text(
                                controller.amountCartItems.toStringAsFixed(2),
                                style: TextStyle(color: Colors.white))),
                        backgroundColor: Theme.of(context).primaryColor),
                    FlatButton(
                        onPressed: () {
                          controller.addOrder(
                            controller.getAll().values.toList(),
                            controller.amountCartItems,
                          );
                          controller.clearCart();
                          Modular.to.pop();
                        },
                        child: Text(CART_LBL_ORDER,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)))
                  ]))),
          SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: controller.getAll().length,
                  itemBuilder: (ctx, item) {
                    print(MON_BUILD_COMP_CARTVIEW_LISTVIEWBUILDER_CARTCARDITEM);
                    return CardCartItem(
                        controller.getAll().values.elementAt(item));
                  }))
        ]));
  }
}
