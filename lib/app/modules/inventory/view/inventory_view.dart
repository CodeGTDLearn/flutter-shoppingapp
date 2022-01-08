import 'package:animations/src/open_container.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import '../../../core/global_widgets/appbar/custom_sliver_appbar.dart';
import '../../../core/global_widgets/custom_indicator.dart';
import '../../../core/icons/modules/inventory_icons.dart';
import '../../../core/keys/modules/inventory_keys.dart';
import '../../../core/labels/message_labels.dart';
import '../../../core/labels/modules/inventory_labels.dart';
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
  final _messages = Get.find<MessageLabels>();
  final _labels = Get.find<InventoryLabels>();
  final _keys = Get.find<InventoryKeys>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      }, actions: [_addNewProductAppbarButton()]),
                      _sliverListView
                          .inventoryListview(_controller.inventoryProductsObs.toList()),
                    ]),
            )),
    ));
  }

  OpenContainer<Object> _addNewProductAppbarButton() {
    return _animations.openContainer(
        milliseconds: 1000,
        openingWidget: InventoryDetailsView(),
        closingWidget: Container(
            key: Key(_keys.k_inv_add_btn_appbar()),
            alignment: Alignment.center,
            child: _icons.ico_add_appbar(),
            width: 50,
            decoration: BoxDecoration(
                color: Colors.pink, border: Border.all(color: Colors.transparent))));
  }
}