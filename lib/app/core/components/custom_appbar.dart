import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/overview/components/appbar_filter_popup.dart';
import '../../modules/overview/components/badge_shop_cart.dart';
import '../../modules/overview/components/filter_favorite_enum.dart';
import '../../modules/overview/controller/overview_controller.dart';
import '../../modules/overview/core/overview_texts_icons_provided.dart';
import '../../modules/overview/core/overview_widget_keys.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final EnumFilter filter = EnumFilter.All;
  final OverviewController _controller = Get.find<OverviewController>();

  CustomAppBar({required enumFilter});

  Widget build(BuildContext context) {
    return AppBar(
        key: Key(K_DRW_APPBAR_BTN),
        title: Obx(() => Text(
            _controller.overviewViewTitleObs == EnumFilter.All
                ? OV_TIT_ALL_APPBAR
                : OV_TIT_FAV_APPBAR,
            key: Key(K_OV_TIT_APPBAR))),
        actions: [AppbarFilterPopup(), BadgeShopCart()]);
  }

  Size get preferredSize => const Size.fromHeight(55);
}
