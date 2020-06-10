import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/app/config/app_properties.dart';
import 'package:shopingapp/app/config/app_routes.dart';
import 'package:shopingapp/app/config/messages/flush_notifier.dart';
import 'package:shopingapp/app/config/titles_icons/app_core.dart';
import 'package:shopingapp/app/config/titles_icons/views/overview.dart';
import 'package:shopingapp/app/modules/core/components/flush_notifier.dart';

import '../overview_grid_product_controller.dart';
import 'popup_options_appbar.dart';

class PopupMenuAppbar extends StatefulWidget {
  bool _enableFavorite;
  bool _enableAll;

  PopupMenuAppbar({@required favoriteOption, @required allOption}) {
    this._enableFavorite = favoriteOption;
    this._enableAll = allOption;
  }

  @override
  _PopupMenuAppbarState createState() => _PopupMenuAppbarState();
}

class _PopupMenuAppbarState
    extends ModularState<PopupMenuAppbar, OverviewGridProductController> {
  final _store = Modular.get<OverviewGridProductControllerBase>();
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _disposers = [
      reaction((_) => (_store.hasFavorites), (value) {
        if (!value) {
          FlushNotifier(SORRY, FLUSHNOTIF_MSG_NOFAV, INTERVAL, context)
              .simple();
          _store.hasFavorites = !value;
        }
      })
    ];
    super.initState();
  }

  @override
  void dispose() {
    _disposers.forEach((dispose) => dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(OVERVIEW_TXT_POPUP_FAV),
                  value: PopupOptionsAppbar.Favorites,
                  enabled: widget._enableFavorite),
              PopupMenuItem(
                  child: Text(OVERVIEW_TXT_POPUP_ALL),
                  value: PopupOptionsAppbar.All,
                  enabled: widget._enableAll)
            ],
        onSelected: (filterSelected) {
          if (filterSelected == PopupOptionsAppbar.All) {
            Modular.to.pushNamed(Modular.initialRoute);
          } else if (_store.qtdeFavorites() > 0) {
            Modular.to.pushNamed(ITEMSOVER_FAV_ROUTE);
          }
          _store.applyFilter(filterSelected);
        });
  }
}
