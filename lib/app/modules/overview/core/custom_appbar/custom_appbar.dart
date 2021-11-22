import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/keys/overview_keys.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../controller/overview_controller.dart';
import 'appbar_filter_options.dart';
import 'appbar_filter_popup.dart';
import 'badge_shop_cart.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppbarFilterOptions filter = AppbarFilterOptions.All;
  final OverviewController _controller = Get.find<OverviewController>();

  CustomAppBar({required filter});

  Widget build(BuildContext context) {
    return Obx(() => AppBar(
        key: Key(K_DRW_APPBAR_BTN),
        title: Text(
            _controller.appbarFilterPopupObs == AppbarFilterOptions.All
                ? OV_TIT_ALL_APPBAR
                : OV_TIT_FAV_APPBAR,
            key: Key(K_OV_TIT_APPBAR)),
        actions: [AppbarFilterPopup(filter: filter), BadgeShopCart()]));
  }

  Size get preferredSize => const Size.fromHeight(55);
}