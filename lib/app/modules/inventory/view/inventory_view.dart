import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/keys/inventory_keys.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../../../core/texts_icons_provider/pages/inventory/inventory_texts_icons_provided.dart';
import '../controller/inventory_controller.dart';
import '../core/custom_listview/inventory_staggered_listview.dart';

class InventoryView extends StatelessWidget {
  final _controller = Get.find<InventoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(INV_TIT_APPBAR), actions: <Widget>[
          IconButton(
              key: Key(K_INV_ADD_BTN),
              icon: INV_ICO_ADD_APPBAR,
              onPressed: () => Get.toNamed(AppRoutes.INVENTORY_EDIT_PRODUCT))
        ]),
        body: Obx(() => (_controller.getInventoryProductsObs().isEmpty
            ? CustomIndicator.message(message: NO_INV_PROD, fontSize: 20)
            : RefreshIndicator(
                onRefresh: _controller.getProducts,
                child: _controller.getInventoryProductsObs().isEmpty
                    ? Center(child: Text(NO_INV_PROD))
                    : InventoryStaggeredListview()
                        .create(_controller.getInventoryProductsObs())))));
  }
}