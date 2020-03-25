import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/enum/itemOverviewPopup.dart';
import 'package:shopingapp/service_stores/items_overview_serv_store.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/widgets/badge.dart';
import 'package:shopingapp/widgets/drawwer.dart';
import 'package:shopingapp/widgets/gridProducts.dart';

class ItemOverviewView extends StatelessWidget {
  final _store = Modular.get<ItemsOverviewServStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(IOS_APPBAR_TITLE),
        actions: [
          PopupMenuButton(
              itemBuilder: (_) => [
                    PopupMenuItem(
                        child: Text(IOS_TXT_POPUP_FAV),
                        value: ItemsOverviewPopup.Favorites),
                    PopupMenuItem(
                        child: Text(IOS_TXT_POPUP_ALL),
                        value: ItemsOverviewPopup.All)
                  ],
              onSelected: (favoritesFilter) =>
                  _store.selectFilter(favoritesFilter)),
          Badge(
              child: IconButton(
                  icon: IOS_ICO_SHOP,
                  onPressed: () {
                    Navigator.pushNamed(context, ROUTE_CART);
                  }),
              value: "10"),
        ],
      ),
      drawer: Drawwer(),
      body: GridProducts(_store.filterSelected),
    );
  }
}
