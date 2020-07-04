import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_routes.dart';
import '../../../config/titles_icons/views/overview.dart';
import '../overview_controller.dart';
import 'popup_appbar_enum.dart';

// ignore: must_be_immutable
class PopupAppbar extends StatelessWidget {
  bool _enableFavorite;
  bool _enableAll;

  PopupAppbar({@required favoriteOption, @required allOption}) {
    _enableFavorite = favoriteOption;
    _enableAll = allOption;
  }

//  List<ReactionDisposer> _disposers;
  final OverviewController controller = Get.put(OverviewController());

//  @override
//  void initState() {
//    _disposers = [
//      reaction((_) => (controller.hasFavorites), (value) {
//        if (!value) {
//          FlushNotifier(SORRY, FLUSHNOTIF_MSG_NOFAV, INTERVAL, context)
//              .simple();
//          controller.hasFavorites = !value;
//        }
//      })
//    ];
//  }
//
//  @override
//  void dispose() {
//    // ignore: avoid_function_literals_in_foreach_calls
//    _disposers.forEach((dispose) => dispose());
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(OVERVIEW_TXT_POPUP_FAV),
                  value: PopupEnum.Fav,
                  enabled: _enableFavorite),
              PopupMenuItem(
                  child: Text(OVERVIEW_TXT_POPUP_ALL),
                  value: PopupEnum.All,
                  enabled: _enableAll)
            ],
        onSelected: (filterSelected) {
          switch (filterSelected) {
            case PopupEnum.Fav:
              Get.toNamed(OVERVIEW_FAV_ROUTE);
              break;
            case PopupEnum.All:
              Get.toNamed(OVERVIEW_ALL_ROUTE);
              break;
          }
        });
  }
}
