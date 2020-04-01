import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/enum/itemOverviewPopup.dart';
import 'package:shopingapp/service_stores/CartStore.dart';
import 'package:shopingapp/service_stores/ItemsOverviewGridProductsStore.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/widgets/badge.dart';

class CartView extends StatelessWidget {
  final _servGridProductsStore = Modular.get<IItemsOverviewGridProductsStore>();
  final _servCartStore = Modular.get<ICartStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(CRT_APPBAR_TITLE), actions: [
        PopupMenuButton(
            itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text(IOS_TXT_POPUP_FAV),
                    value: ItemsOverviewPopup.Favorites,
                    enabled: _servGridProductsStore.totalFavoritesQtde() != 0 ? true : false,
                  ),
                  PopupMenuItem(child: Text(IOS_TXT_POPUP_ALL), value: ItemsOverviewPopup.All)
                ],
            onSelected: (popupOptionSelected) =>
                _servGridProductsStore.applyFilter(popupOptionSelected, context))
      ]),
      body: Column(
        children: [
          Card(
              child: Row(children: <Widget>[
            Text(CRT_TXT_CARD),
            Chip(
                label: Text(_servCartStore.getTotalCartAmount(),
                    style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color))),
            Spacer(),
            FlatButton(
                onPressed: null,
                child: Text(CRT_TXT_ORDER,
                    style: TextStyle(color: Theme.of(context).primaryTextTheme.title.color)))
          ])),
          SizedBox(height: 10),
          Expanded()
        ],
      ),
    );
  }
}
