import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../../core/custom_widgets/snackbar/simple_snackbar.dart';
import '../../../../core/keys/modules/overview_keys.dart';
import '../../../../core/texts/general_words.dart';
import '../../../../core/texts/messages.dart';
import '../../../../core/texts/modules/overview_labels.dart';
import '../../controller/overview_controller.dart';
import 'filter_options.dart';

// ignore: must_be_immutable
class FilterPopup extends StatelessWidget {
  final _controller = Get.find<OverviewController>();
  final FilterOptions filter = FilterOptions.All;
  final _messages = Get.find<Messages>();
  final _words = Get.find<GeneralWords>();
  final _labels = Get.find<OverviewLabels>();


  FilterPopup({required filter});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: Key(K_OV06),
        itemBuilder: (_) => [
              PopupMenuItem(
                  key: Key(K_OV_FLT_FAV),
                  child: Text(_labels.label_popup_fav()),
                  value: FilterOptions.Fav,
                  enabled: _controller.appbarFilterOptionObs.value == FilterOptions.All),
              PopupMenuItem(
                  key: Key(K_OV_FLT_ALL),
                  child: Text(_labels.label_popup_all()),
                  value: FilterOptions.All,
                  enabled: _controller.appbarFilterOptionObs.value == FilterOptions.Fav)
            ],
        onSelected: (value) {
          _controller.getFavoritesQtde() == 0
              ? SimpleSnackbar().show(_words.ops(), _messages.overview_no_favs_yet())
              : value == FilterOptions.All
                  ? _controller.applyPopupFilter(FilterOptions.All)
                  : _controller.applyPopupFilter(FilterOptions.Fav);
        });
  }
}