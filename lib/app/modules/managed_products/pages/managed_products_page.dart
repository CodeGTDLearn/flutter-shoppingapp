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

//The following assertion was thrown building _BodyBuilder:
//setState() or markNeedsBuild() called during build.
//
//This GetBuilder<ManagedProductsController> widget cannot be marked as needing to build because the framework is already in the process of building widgets.  A widget can be marked as needing to be built during the build phase only if one of its ancestors is currently building. This exception is allowed because the framework builds parent widgets before children, which means a dirty descendant will always be built. Otherwise, the framework might not visit this widget during this build phase.
//The widget on which setState() or markNeedsBuild() was called was: GetBuilder<ManagedProductsController>
//state: _GetBuilderState<ManagedProductsController>#2f87d
//The widget which was currently being built when the offending call was made was: _BodyBuilder
//The relevant error-causing widget was:
//Scaffold file:///C:/Users/SERVIDOR/Projects/flutter-shoppingapp/lib/app/modules/managed_products/pages/managed_products_page.dart:13:12
//When the exception was thrown, this was the stack:
//#0      Element.markNeedsBuild.<anonymous closure> (package:flutter/src/widgets/framework.dart:4167:11)
//#1      Element.markNeedsBuild (package:flutter/src/widgets/framework.dart:4182:6)
//#2      State.setState (package:flutter/src/widgets/framework.dart:1253:14)
//#3      GetxController.update.<anonymous closure> (package:get/src/state/get_state.dart:15:25)
//#4      _SetBase.forEach (dart:collection/set.dart:438:30)
