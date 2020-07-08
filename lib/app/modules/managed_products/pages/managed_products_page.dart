import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_routes.dart';
import '../../../config/titles_icons/views/managed_products.dart';
import '../../core/components/drawwer.dart';
import '../components/managed_product_item.dart';
import '../managed_products_controller.dart';

class ManagedProductsPage extends StatelessWidget {

  // GERENCIA DE ESTADO REATIVA - COM O GET
  final ManagedProductsController c = Get.put(ManagedProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MAN_APPBAR_TIT), actions: <Widget>[
        IconButton(
            icon: MAN_ADD_APPBAR_ICO,
            onPressed: () => Get.toNamed(MAN_PROD_ADD_EDIT_ROUTE))
      ]),
      drawer: Drawwer(),
      //------

      // GERENCIA DE ESTADO REATIVA - COM O GET
      body: Obx(() =>
          ListView.builder(
              itemCount: c.managedProducts.length,
              itemBuilder: (ctx, item) => Column(children: [
                ManagedProductItem(
                  c.managedProducts[item].id,
                  c.managedProducts[item].title,
                  c.managedProducts[item].imageUrl,
                ),
                Divider()
              ]))),

      // GERENCIA DE ESTADO SIMPLES - COM O GET
//      body: GetBuilder<ManagedProductsController>(
//          init: ManagedProductsController(),
//          builder: (_) => ListView.builder(
//              itemCount: _.managedProducts.length,
//              itemBuilder: (ctx, item) => Column(children: [
//                    ManagedProductItem(
//                      _.managedProducts[item].id,
//                      _.managedProducts[item].title,
//                      _.managedProducts[item].imageUrl,
//                    ),
//                    Divider()
//                  ]))),

      //----------
    );
  }
}

