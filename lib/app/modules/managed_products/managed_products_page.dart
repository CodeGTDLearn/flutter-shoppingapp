import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../config/app_monitor_builds.dart';
import '../../config/app_routes.dart';
import '../../config/titles_icons/views/managed_products.dart';
import '../../modules/core/components/drawwer.dart';
import 'components/managed_product_item.dart';
import 'managed_products_controller.dart';

class ManagedProductsPage extends StatefulWidget {
  @override
  _ManagedProductsPageState createState() => _ManagedProductsPageState();
}

class _ManagedProductsPageState
    extends ModularState<ManagedProductsPage, ManagedProductsController> {
  @override
  void initState() {
    controller.getAll();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MON_BUILD_VIEW_MANAGPRODUCTS);
    final test = Modular.get<ManagedProductsController>();// todo:Esta nulificando

    print("1111" + test.toString());
    return Scaffold(
      appBar: AppBar(title: Text(MAN_APPBAR_TIT), actions: <Widget>[
        IconButton(
            icon: MAN_ADD_APPBAR_ICO,
            onPressed: () => Modular.link.pushNamed(MANAGPRODUCT_ADD_ROUTE))
      ]),
      drawer: Drawwer(),
      body: Observer(
          builder: (_) => ListView.builder(
              itemCount: controller.managedProducts.length,
              itemBuilder: (ctx, item) => Column(children: [
                    ManagedProductItem(
                      controller.managedProducts[item].get_id(),
                      controller.managedProducts[item].get_title(),
                      controller.managedProducts[item].get_imageUrl(),
                    ),
                    Divider()
                  ]))),
    );
  }
}
