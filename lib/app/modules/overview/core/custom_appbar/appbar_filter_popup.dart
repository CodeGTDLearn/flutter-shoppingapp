import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../../core/custom_widgets/custom_snackbar/simple_snackbar.dart';
import '../../../../core/keys/overview_keys.dart';
import '../../../../core/texts_icons_provider/generic_words.dart';
import '../../../../core/texts_icons_provider/pages/overview/messages_snackbars_provided.dart';
import '../../../../core/texts_icons_provider/pages/overview/overview_texts_icons_provided.dart';
import '../../controller/overview_controller.dart';
import 'appbar_filter_options.dart';

// ignore: must_be_immutable
class AppbarFilterPopup extends StatelessWidget {
  final _controller = Get.find<OverviewController>();
  final AppbarFilterOptions filter = AppbarFilterOptions.All;

  AppbarFilterPopup({required filter});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: Key(K_OV06),
        itemBuilder: (_) => [
              PopupMenuItem(
                  key: Key(K_OV_FLT_FAV),
                  child: Text(OV_TXT_POPUP_FAV),
                  value: AppbarFilterOptions.Fav,
                  enabled:
                      _controller.appbarFilterPopupObs.value == AppbarFilterOptions.All),
              PopupMenuItem(
                  key: Key(K_OV_FLT_ALL),
                  child: Text(OV_TXT_POPUP_ALL),
                  value: AppbarFilterOptions.All,
                  enabled:
                      _controller.appbarFilterPopupObs.value == AppbarFilterOptions.Fav)
            ],
        onSelected: (value) {
          _controller.getFavoritesQtde() == 0
              ? SimpleSnackbar(OPS, OVERVIEW_NO_ITEMS_FAVS_YET).show()
              : value == AppbarFilterOptions.All
                  ? _controller.applyPopupFilter(AppbarFilterOptions.All)
                  : _controller.applyPopupFilter(AppbarFilterOptions.Fav);
        });
  }
}