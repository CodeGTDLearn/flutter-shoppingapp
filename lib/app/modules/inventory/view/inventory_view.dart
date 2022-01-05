import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/custom_widgets/appbar/custom_sliver_appbar.dart';
import '../../../core/custom_widgets/custom_indicator.dart';
import '../../../core/icons/modules/inventory/inventory_icons.dart';
import '../../../core/keys/modules/inventory_keys.dart';
import '../../../core/texts/messages.dart';
import '../../../core/texts/modules/inventory_labels.dart';
import '../../../core/utils/animations_utils.dart';
import '../../overview/controller/overview_controller.dart';
import '../components/custom_listview/icustom_inventory_listview.dart';
import '../controller/inventory_controller.dart';
import 'inventory_details_view.dart';

class InventoryView extends StatelessWidget {
  final _controller = Get.find<InventoryController>();
  final _overviewController = Get.find<OverviewController>();
  final _sliverAppbar = Get.find<CustomSliverAppBar>();
  final _animations = Get.find<AnimationsUtils>();
  final _sliverListView = Get.find<ICustomInventoryListview>();
  final _icons = Get.find<InventoryIcons>();
  final _messages = Get.find<Messages>();
  final _labels = Get.find<InventoryLabels>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar:
        body: Obx(
      () => (_controller.inventoryProductsObs.toList().isEmpty
          ? CustomIndicator.message(message: _messages.no_inv_prod_yet(), fontSize: 20)
          : RefreshIndicator(
              onRefresh: _controller.getProducts,
              child: _controller.inventoryProductsObs.toList().isEmpty
                  ? Center(child: Text(_messages.no_inv_prod_yet()))
                  : CustomScrollView(slivers: [
                      _sliverAppbar.create(_labels.inv_tit_page(), () {
                        _overviewController.updateFilteredProductsObs();
                        Get.back();
                      }, actions: [
                        _animations.openContainer(
                            milliseconds: 1000,
                            openingWidget: InventoryDetailsView(),
                            closingWidget: Container(
                                key: Key(K_INV_ICO_ADD_PROD_APPBAR),
                                alignment: Alignment.center,
                                child: _icons.ico_add_appbar(),
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    border: Border.all(color: Colors.transparent))))
                      ]),
                      _sliverListView
                          .inventoryListview(_controller.inventoryProductsObs.toList()),
                    ]),
            )),
    ));
  }
}