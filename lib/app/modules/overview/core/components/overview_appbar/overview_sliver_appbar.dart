import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';

import '../../../controller/overview_controller.dart';
import '../../overview_keys.dart';
import '../../overview_labels.dart';
import 'filter_options_enum.dart';
import 'filter_popup.dart';

class OverviewSliverAppBar extends StatelessWidget implements PreferredSizeWidget {
  final FilterOptionsEnum filter = FilterOptionsEnum.All;
  final _controller = Get.find<OverviewController>();
  final _labels = Get.find<OverviewLabels>();
  final _keys = Get.find<OverviewKeys>();
  late Widget? cart;

  OverviewSliverAppBar({this.cart});

  Widget build(BuildContext context) {
    return Obx(() => SliverAppBar(
            key: Key(_keys.k_ov_sl_appbar()),
            floating: true,
            title: Text(
                _controller.appbarFilterOptionObs == FilterOptionsEnum.All
                    ? _labels.title_appbar
                    : _labels.title_fav,
                key: Key(_keys.k_ov_sl_tit_appbar())),
            actions: [
              FilterPopup(filter: filter),
              cart ??= Container(),
            ]));
  }

  Size get preferredSize => const Size.fromHeight(55);
}