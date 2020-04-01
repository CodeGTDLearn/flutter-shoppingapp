import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/enum/itemOverviewPopup.dart';
import 'package:shopingapp/service_stores/ItemsOverviewGridProductsStore.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/widgets/badge.dart';

class CartView extends StatelessWidget {

  final _servStore = Modular.get<IItemsOverviewGridProductsStore>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CRT_APPBAR_TITLE),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(IOS_TXT_POPUP_FAV),
                value: ItemsOverviewPopup.Favorites,
                enabled: _servStore.totalFavoritesQtde() != 0 ? true : false,
              ),
              PopupMenuItem(child: Text(IOS_TXT_POPUP_ALL), value: ItemsOverviewPopup.All)
            ],
            onSelected: (popupOptionSelected) =>
                _servStore.applyFilter(popupOptionSelected, context),
          ),

        ],
      ),
    );
  }
}
