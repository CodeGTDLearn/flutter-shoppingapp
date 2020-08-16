import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../../core/properties/app_routes.dart';
import '../../pages_generic_components/drawwer.dart';
import '../components/managed_product_item.dart';
import '../controller/managed_products_controller.dart';
import '../core/messages_provided/message_db_empty_provided.dart';
import '../core/texts_icons_provided/managed_products_texts_icons_provided.dart';

class ManagedProductsPage extends StatelessWidget {
  final ManagedProductsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MAN_PROD_TIT_APPBAR), actions: <Widget>[
        IconButton(
            icon: MAN_PROD_ICO_ADD_APPBAR,
            onPressed: () => Get.toNamed(AppRoutes.MAN_PROD_ADD_EDIT_ROUTE))
      ]),
      drawer: Drawwer(),

      //------
      // GERENCIA DE ESTADO REATIVA - COM O GET
      body: controller.managedProducts.length == 0
          ? Center(child: Text(MAN_PROD_NO_DATA, style: TextStyle(fontSize: 20)))
          : Obx(() => ListView.builder(
              itemCount: controller.managedProducts.length,
              itemBuilder: (ctx, item) => Column(children: [
                    ManagedProductItem(
                      controller.managedProducts[item].id,
                      controller.managedProducts[item].title,
                      controller.managedProducts[item].imageUrl,
//                  controller.managedProducts[item].imageUrl,
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

