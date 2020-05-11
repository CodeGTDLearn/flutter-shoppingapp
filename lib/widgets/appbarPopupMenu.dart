import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons/ItemOverviewView.dart';

import 'package:shopingapp/enum/itemOverviewPopup.dart';
import 'package:shopingapp/service_stores/itemsOverviewGridProductsStore.dart';

class AppbarPopupMenu extends StatelessWidget {
  bool _enableFavorite;
  bool _enableAll;


  AppbarPopupMenu({@required favoriteOption, @required allOption}){
    this._enableFavorite = favoriteOption;
    this._enableAll = allOption;
  }

  @override
  Widget build(BuildContext context) {
    final _store = Modular.get<ItemsOverviewGridProductsStoreInt>();
    return PopupMenuButton(
        itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(IOS_TXT_POPUP_FAV),
                value: ItemsOverviewPopup.Favorites,
                enabled: _enableFavorite,
              ),
              PopupMenuItem(
                child: Text(IOS_TXT_POPUP_ALL),
                value: ItemsOverviewPopup.All,
                enabled: _enableAll,
              )
            ],
        onSelected: (filterSelected) {
          if (filterSelected == ItemsOverviewPopup.All) {
            Modular.to.pushNamed(RT_OVERV_VIEW);
          } else if (_store.totalFavoritesQtde() > 0) {
            Modular.to.pushNamed(RT_OVERV_FAV_VIEW);
          }
          _store.applyFilter(filterSelected, context);
        });
  }
}
