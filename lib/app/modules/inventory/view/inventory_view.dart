import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shopingapp/app/core/custom_widgets/custom_appbar.dart';
import 'package:shopingapp/app/core/keys/inventory_keys.dart';

import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/properties/app_routes.dart';
import '../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../../../core/texts_icons_provider/pages/inventory/inventory_texts_icons_provided.dart';
import '../../overview/controller/overview_controller.dart';
import '../controller/inventory_controller.dart';
import '../core/custom_listview/inventory_staggered_listview.dart';

class InventoryView extends StatelessWidget {
  final _controller = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();
  final _appbar = Get.find<CustomAppBar>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar.create(INV_TIT_APPBAR, () {
          _overviewController.updateFilteredProductsObs();
          Get.offNamed(AppRoutes.OVERVIEW_ALL);
        }, [
          IconButton(
              key: Key(K_INV_ICO_ADD_PROD_APPBAR),
              icon: INV_ICO_ADD_PROD_APPBAR,
              onPressed: () => Get.offNamed(AppRoutes.INVENTORY_ITEM_DETAILS))
        ]),
        body: Obx(() => (_controller.inventoryProductsObs.toList().isEmpty
            ? CustomIndicator.message(message: NO_INV_PROD, fontSize: 20)
            : RefreshIndicator(
                onRefresh: _controller.getProducts,
                child: _controller.inventoryProductsObs.toList().isEmpty
                    ? Center(child: Text(NO_INV_PROD))
                    : InventoryStaggeredListview()
                        .create(_controller.inventoryProductsObs.toList())))));
  }
}