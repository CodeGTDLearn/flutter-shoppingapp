import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../../../core/components/snackbar/core_snackbar.dart';
import '../../../../../core/texts/core_labels.dart';
import '../../../../../core/texts/core_messages.dart';
import '../../../controller/overview_controller.dart';
import '../../overview_keys.dart';
import '../../overview_labels.dart';
import 'filter_options_enum.dart';

// ignore: must_be_immutable
class FilterPopup extends StatelessWidget {
  final _controller = Get.find<OverviewController>();
  final FilterOptionsEnum filter = FilterOptionsEnum.All;
  final _messages = Get.find<CoreMessages>();
  final _words = Get.find<CoreLabels>();
  final _labels = Get.find<OverviewLabels>();
  final _keys = Get.find<OverviewKeys>();

  FilterPopup({required filter});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: Key(_keys.k_ov06()),
        itemBuilder: (_) => [
              PopupMenuItem(
                  key: Key(_keys.k_ov_flt_fav()),
                  child: Text(_labels.popup_fav),
                  value: FilterOptionsEnum.Fav,
                  enabled:
                      _controller.appbarFilterOptionObs.value == FilterOptionsEnum.All),
              PopupMenuItem(
                  key: Key(_keys.k_ov_flt_all()),
                  child: Text(_labels.popup_all),
                  value: FilterOptionsEnum.All,
                  enabled:
                      _controller.appbarFilterOptionObs.value == FilterOptionsEnum.Fav)
            ],
        onSelected: (value) {
          _controller.getFavoritesQtde() == 0
              ? CoreSnackbar().show(_words.ops(), _messages.overview_no_favs_yet)
              : value == FilterOptionsEnum.All
                  ? _controller.applyPopupFilter(FilterOptionsEnum.All)
                  : _controller.applyPopupFilter(FilterOptionsEnum.Fav);
        });
  }
}