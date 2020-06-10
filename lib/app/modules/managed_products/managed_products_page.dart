import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/app/config/app_monitor_builds.dart';
import 'package:shopingapp/app/config/app_routes.dart';
import 'package:shopingapp/app/config/titles_icons/views/managed_products.dart';
import 'package:shopingapp/app/modules/core/components/drawwer.dart';

import 'components/managed_product_item.dart';
import 'managed_products_controller.dart';

class ManagedProductsPage extends StatefulWidget {
  @override
  _ManagedProductsPageState createState() => _ManagedProductsPageState();
}

class _ManagedProductsPageState
    extends ModularState<ManagedProductsPage, ManagedProductsController> {
//  final _store = Modular.get<ManagedProductsController>();

  @override
  void initState() {
//    _store.getAll();
    controller.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_VIEW_MANAGPRODSEDIT);
    return Scaffold(
      appBar: AppBar(title: Text(MAN_APPBAR_TIT), actions: <Widget>[
        IconButton(
            icon: MAN_ADD_APPBAR_ICO,
            onPressed: () => Modular.link.pushNamed(MANAGPRODUCT_ADD_ROUTE))
      ]),
      drawer: Drawwer(),
      body: Observer(
          builder: (BuildContext _) => ListView.builder(
//              itemCount: _store.products.length,
              itemCount: controller.products.length,
              itemBuilder: (ctx, item) => Column(children: <Widget>[
                    ManagedProductItem(
//                      _store.products[item].get_id(),
                      controller.products[item].get_id(),
//                      _store.products[item].get_title(),
                      controller.products[item].get_title(),
//                      _store.products[item].get_imageUrl(),
                      controller.products[item].get_imageUrl(),
                    ),
                    Divider()
                  ]))),
    );
  }
}
