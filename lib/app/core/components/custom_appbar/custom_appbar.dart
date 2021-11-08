import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modules/overview/controller/overview_controller.dart';
import '../../../modules/overview/core/overview_texts_icons_provided.dart';
import '../../../modules/overview/core/overview_widget_keys.dart';
import 'appbar_filter_popup.dart';
import 'badge_shop_cart.dart';
import 'filter_favorite_enum.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final EnumFilter filter = EnumFilter.All;
  final OverviewController _controller = Get.find<OverviewController>();

  CustomAppBar({required filter});

  Widget build(BuildContext context) {
    return Obx(() => AppBar(
        key: Key(K_DRW_APPBAR_BTN),
        title: Text(
            _controller.appbarFilterPopupObs == EnumFilter.All
                ? OV_TIT_ALL_APPBAR
                : OV_TIT_FAV_APPBAR,
            key: Key(K_OV_TIT_APPBAR)),
        actions: [AppbarFilterPopup(filter: filter), BadgeShopCart()]));
  }

  Size get preferredSize => const Size.fromHeight(55);
}