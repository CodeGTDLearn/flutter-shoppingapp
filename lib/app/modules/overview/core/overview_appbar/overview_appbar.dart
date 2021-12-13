import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/keys/overview_keys.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../controller/overview_controller.dart';
import 'filter_options.dart';
import 'filter_popup.dart';

class OverviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FilterOptions filter = FilterOptions.All;
  final _controller = Get.find<OverviewController>();
  late Widget? cart;

  OverviewAppBar({this.cart});

  Widget build(BuildContext context) {
    return Obx(() => AppBar(
            key: Key(K_DRW_APPBAR_BTN),
            title: Text(
                _controller.appbarFilterOptionObs == FilterOptions.All
                    ? OV_TIT_ALL_APPBAR
                    : OV_TIT_FAV_APPBAR,
                key: Key(K_OV_TIT_APPBAR)),
            actions: [
              FilterPopup(filter: filter),
              cart ??= Container(),
            ]));
  }

  Size get preferredSize => const Size.fromHeight(55);
}