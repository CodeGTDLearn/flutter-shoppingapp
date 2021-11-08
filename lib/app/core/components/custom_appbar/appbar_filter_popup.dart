import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../modules/overview/controller/overview_controller.dart';
import '../../../modules/overview/core/messages_snackbars_provided.dart';
import '../../../modules/overview/core/overview_texts_icons_provided.dart';
import '../../../modules/overview/core/overview_widget_keys.dart';
import '../../texts_icons_provider/generic_words.dart';
import '../custom_snackbar/simple_snackbar.dart';
import 'filter_favorite_enum.dart';

// ignore: must_be_immutable
class AppbarFilterPopup extends StatelessWidget {
  final OverviewController _controller = Get.find<OverviewController>();
  final EnumFilter filter = EnumFilter.All;

  AppbarFilterPopup({required filter});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: Key(K_OV06),
        itemBuilder: (_) => [
              PopupMenuItem(
                  key: Key(K_OV_FLT_FAV),
                  child: Text(OV_TXT_POPUP_FAV),
                  value: EnumFilter.Fav,
                  enabled: _controller.appbarFilterPopupObs.value == EnumFilter.All),
              PopupMenuItem(
                  child: Text(OV_TXT_POPUP_ALL, key: Key(K_OV_FLT_ALL)),
                  value: EnumFilter.All,
                  enabled: _controller.appbarFilterPopupObs.value == EnumFilter.Fav)
            ],
        onSelected: (value) {
          _controller.getFavoritesQtde() == 0
              ? SimpleSnackbar(OPS, OVERVIEW_NO_ITEMS_FAVS_YET).show()
              : value == EnumFilter.All
                  ? _controller.applyFilter(EnumFilter.All)
                  : _controller.applyFilter(EnumFilter.Fav);
        });
  }
}