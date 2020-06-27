import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/app/config/app_routes.dart';

import '../../../config/app_properties.dart';
import '../../../config/messages/flush_notifier.dart';
import '../../../config/titles_icons/app_core.dart';
import '../../../config/titles_icons/views/overview.dart';
import '../../../modules/core/components/flush_notifier.dart';
import '../overview_controller.dart';
import 'popup_appbar_enum.dart';

// ignore: must_be_immutable
class PopupAppbar extends StatefulWidget {
  bool _enableFavorite;
  bool _enableAll;

  PopupAppbar({@required favoriteOption, @required allOption}) {
    _enableFavorite = favoriteOption;
    _enableAll = allOption;
  }

  @override
  _PopupAppbarState createState() => _PopupAppbarState();
}

class _PopupAppbarState extends ModularState<PopupAppbar, OverviewController> {
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _disposers = [
      reaction((_) => (controller.hasFavorites), (value) {
        if (!value) {
          FlushNotifier(SORRY, FLUSHNOTIF_MSG_NOFAV, INTERVAL, context)
              .simple();
          controller.hasFavorites = !value;
        }
      })
    ];
    super.initState();
  }

  @override
  void dispose() {
    // ignore: avoid_function_literals_in_foreach_calls
    _disposers.forEach((dispose) => dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(OVERVIEW_TXT_POPUP_FAV),
                  value: PopupEnum.Favorites,
                  enabled: widget._enableFavorite),
              PopupMenuItem(
                  child: Text(OVERVIEW_TXT_POPUP_ALL),
                  value: PopupEnum.All,
                  enabled: widget._enableAll)
            ],
        onSelected: (filterSelected) {
          switch (filterSelected) {
            case PopupEnum.Favorites:
              Modular.to.pushNamed(OVERVIEW_FAV_ROUTE);
              break;
            case PopupEnum.All:
              Modular.to.pushNamed(OVERVIEW_ALL_ROUTE);
              break;
          }
//          if (filterSelected == PopupAppbarEnum.All) {
//            Modular.to.pushNamed(Modular.initialRoute);
//          } else if (controller.qtdeFavorites() > 0) {
//            Modular.to.pushNamed(ITEMSOVER_FAV_ROUTE);
//          }
//          controller.applyFilter(filterSelected);
        });
  }
}
