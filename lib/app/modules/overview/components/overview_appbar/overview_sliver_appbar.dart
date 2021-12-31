import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/keys/overview_keys.dart';
import '../../../../core/texts/modules/overview.dart';
import '../../controller/overview_controller.dart';
import 'filter_options.dart';
import 'filter_popup.dart';

class OverviewSliverAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FilterOptions filter = FilterOptions.All;
  final _controller = Get.find<OverviewController>();
  late Widget? cart;

  OverviewSliverAppBar({this.cart});

  Widget build(BuildContext context) {
    return Obx(() => SliverAppBar(
            key: Key(K_DRW_APPBAR_BTN),
            floating: true,
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