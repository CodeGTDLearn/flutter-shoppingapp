import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/keys/modules/overview_keys.dart';
import '../../../../core/texts/modules/overview_labels.dart';
import '../../controller/overview_controller.dart';
import 'filter_options.dart';
import 'filter_popup.dart';

class OverviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FilterOptions filter = FilterOptions.All;
  final _controller = Get.find<OverviewController>();
  final _labels= Get.find<OverviewLabels>();
  late Widget? cart;

  OverviewAppBar({this.cart});

  Widget build(BuildContext context) {
    return Obx(() => AppBar(
            key: Key(K_DRW_APPBAR_BTN),
            title: Text(
                _controller.appbarFilterOptionObs == FilterOptions.All
                    ? _labels.label_title_appbar()
                    : _labels.label_title_fav(),
                key: Key(K_OV_TIT_APPBAR)),
            actions: [
              FilterPopup(filter: filter),
              cart ??= Container(),
            ]));
  }

  Size get preferredSize => const Size.fromHeight(55);
}