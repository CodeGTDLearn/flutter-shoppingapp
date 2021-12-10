import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/overview_keys.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/overview/messages_snackbars_provided.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../controller/overview_controller.dart';
import 'filter_options.dart';

// ignore: must_be_immutable
class FilterPopup extends StatelessWidget {
  final _controller = Get.find<OverviewController>();
  final FilterOptions filter = FilterOptions.All;

  FilterPopup({required filter});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: Key(K_OV06),
        itemBuilder: (_) => [
              PopupMenuItem(
                  key: Key(K_OV_FLT_FAV),
                  child: Text(OV_TXT_POPUP_FAV),
                  value: FilterOptions.Fav,
                  enabled: _controller.appbarFilterOptionObs.value == FilterOptions.All),
              PopupMenuItem(
                  key: Key(K_OV_FLT_ALL),
                  child: Text(OV_TXT_POPUP_ALL),
                  value: FilterOptions.All,
                  enabled: _controller.appbarFilterOptionObs.value == FilterOptions.Fav)
            ],
        onSelected: (value) {
          _controller.getFavoritesQtde() == 0
              ? SimpleSnackbar().show(OPS, OVERVIEW_NO_ITEMS_FAVS_YET)
              : value == FilterOptions.All
                  ? _controller.applyPopupFilter(FilterOptions.All)
                  : _controller.applyPopupFilter(FilterOptions.Fav);
        });
  }
}