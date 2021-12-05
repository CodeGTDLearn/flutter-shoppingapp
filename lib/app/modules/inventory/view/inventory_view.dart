import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/custom_appbar.dart';
import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/keys/inventory_keys.dart';
import '../../../core/texts_icons_provider/pages/components/app_messages_provided.dart';
import '../../../core/texts_icons_provider/pages/inventory/inventory_texts_icons_provided.dart';
import '../../../core/utils/animations_utils.dart';
import '../../overview/controller/overview_controller.dart';
import '../controller/inventory_controller.dart';
import '../core/custom_listview/inventory_staggered_listview.dart';
import 'inventory_item_details_view.dart';

class InventoryView extends StatelessWidget {
  final _controller = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();
  final _appbar = Get.find<CustomAppBar>();
  final _animations = Get.find<AnimationsUtils>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar.create(INV_TIT_APPBAR, () {
          _overviewController.updateFilteredProductsObs();
          Get.back();
        }, actions: [
          _animations.openContainer(
              milliseconds: 1000,
              openBuilder: InventoryItemDetailsView(),
              closedBuilder: Container(
                decoration: BoxDecoration(
                    color: Colors.pink, border: Border.all(color: Colors.transparent)),
                width: 50,
                alignment: Alignment.center,
                key: Key(K_INV_ICO_ADD_PROD_APPBAR),
                child: INV_ICO_ADD_PROD_APPBAR,
              ))
          // IconButton(
          //     key: Key(K_INV_ICO_ADD_PROD_APPBAR),
          //     icon: INV_ICO_ADD_PROD_APPBAR,
          //     onPressed: () => Get.to(() => InventoryItemDetailsView()))
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