import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../../core/keys/modules/overview_keys.dart';
import '../../../../core/labels/modules/overview_labels.dart';
import '../../controller/overview_controller.dart';
import 'filter_options_enum.dart';
import 'filter_popup.dart';

class OverviewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FilterOptionsEnum filter = FilterOptionsEnum.All;
  final _controller = Get.find<OverviewController>();
  final _labels= Get.find<OverviewLabels>();
  final _keys = Get.find<OverviewKeys>();
  late Widget? cart;

  OverviewAppBar({this.cart});

  Widget build(BuildContext context) {
    return Obx(() => AppBar(
            key: Key(_keys.k_ov_appbar()),
            title: Text(
                _controller.appbarFilterOptionObs == FilterOptionsEnum.All
                    ? _labels.label_title_appbar()
                    : _labels.label_title_fav(),
                key: Key(_keys.k_ov_tit_appbar())),
            actions: [
              FilterPopup(filter: filter),
              cart ??= Container(),
            ]));
  }

  Size get preferredSize => const Size.fromHeight(55);
}