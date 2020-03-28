import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/enum/itemOverviewPopup.dart';
import 'package:shopingapp/service_stores/ItemsOverviewGridProductsStore.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/widgets/badge.dart';

class CartView extends StatelessWidget {
  final store = Modular.get<IItemsOverviewGridProductsStore>();

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
                  value: ItemsOverviewPopup.Favorites),
              PopupMenuItem(
                  child: Text(IOS_TXT_POPUP_ALL), value: ItemsOverviewPopup.All)
            ],
            onSelected: (popupOptionSelected) =>
                store.applyFilter(popupOptionSelected),
          ),
          Badge(child: null, value: "10"),
          IconButton(
              icon: IOS_ICO_SHOP,
              onPressed: () {
                Modular.to.pushNamed(ROUTE_ITEM_OVERV_VIEW);
              })
        ],
      ),
    );
  }
}
