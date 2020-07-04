import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_routes.dart';
import '../../../config/titles_icons/views/managed_products.dart';
import '../../core/components/drawwer.dart';
import '../components/managed_product_item.dart';
import '../managed_products_controller.dart';

class ManagedProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text(MAN_APPBAR_TIT), actions: <Widget>[
          IconButton(
              icon: MAN_ADD_APPBAR_ICO,
              onPressed: () => Get.toNamed(MAN_PROD_ADD_EDIT_ROUTE))
        ]),
        drawer: Drawwer(),
        body: GetBuilder<ManagedProductsController>(
            init: ManagedProductsController(),
            initState: (_) => ManagedProductsController.to.getAll(),
            builder: (_) {
              return ListView.builder(
                  itemCount: _.managedProducts.length,
                  itemBuilder: (ctx, item) => Column(children: [
                        ManagedProductItem(
                          _.managedProducts[item].id,
                          _.managedProducts[item].title,
                          _.managedProducts[item].imageUrl,
                        ),
                        Divider()
                      ]));
            }));
  }
}
