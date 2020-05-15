import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../config/appProperties.dart';
import '../config/titlesIconsMessages/views/ItemOverviewView.dart';
import '../config/titlesIconsMessages/widgets/flushNotifier.dart';

import '../enum/itemOverviewPopup.dart';
import '../service_stores/itemsOverviewGridProductsStore.dart';

import 'flushNotifier.dart';

class AppbarPopupMenu extends StatefulWidget {
  bool _enableFavorite;
  bool _enableAll;

  AppbarPopupMenu({@required favoriteOption, @required allOption}) {
    this._enableFavorite = favoriteOption;
    this._enableAll = allOption;
  }

  @override
  _AppbarPopupMenuState createState() => _AppbarPopupMenuState();
}

class _AppbarPopupMenuState extends State<AppbarPopupMenu> {
  final _store = Modular.get<ItemsOverviewGridProductsStoreInt>();
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _disposers = [
      reaction((_) => (_store.hasFavorites), (value) {
        if (!value) {
          FlushNotifier(SORRY, MSG_NOFAV, FLSH_TIME, context).simple();
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
    final _store = Modular.get<ItemsOverviewGridProductsStoreInt>();
    return PopupMenuButton(
        itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text(IOV_TXT_POPUP_FAV),
                  value: ItemsOverviewPopup.Favorites,
                  enabled: widget._enableFavorite),
              PopupMenuItem(
                  child: Text(IOV_TXT_POPUP_ALL),
                  value: ItemsOverviewPopup.All,
                  enabled: widget._enableAll)
            ],
        onSelected: (filterSelected) {
          if (filterSelected == ItemsOverviewPopup.All) {
            Modular.to.pushNamed(RT_IOV_ALL_VIEW);
          } else if (_store.totalFavoritesQtde() > 0) {
            Modular.to.pushNamed(RT_IOV_FAV_VIEW);
          }
          _store.applyFilter(filterSelected, context);
        });
  }
}
