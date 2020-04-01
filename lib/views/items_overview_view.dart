import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/widgets/flushNotifier.dart';

import '../enum/itemOverviewPopup.dart';
import '../service_stores/ItemsOverviewGridProductsStore.dart';
import '../config/appProperties.dart';
import '../config/titlesIcons.dart';
import '../widgets/badge.dart';
import '../widgets/drawwer.dart';
import '../widgets/gridProducts.dart';

class ItemsOverviewView extends StatefulWidget {
  @override
  _ItemsOverviewViewState createState() => _ItemsOverviewViewState();
}

class _ItemsOverviewViewState extends State<ItemsOverviewView> {
  final _servStore = Modular.get<IItemsOverviewGridProductsStore>();

  @override
  void initState() {
    _servStore.applyFilter(ItemsOverviewPopup.All, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(IOS_APPBAR_TITLE), actions: [
        PopupMenuButton(
            itemBuilder: (_) => [
                  PopupMenuItem(
                      child: Text(IOS_TXT_POPUP_FAV), value: ItemsOverviewPopup.Favorites),
                  PopupMenuItem(
                    child: Text(
                      IOS_TXT_POPUP_ALL,
                    ),
                    value: ItemsOverviewPopup.All,
                    enabled: false,
                  )
                ],
            onSelected: (filterSelected) {
              if (filterSelected == ItemsOverviewPopup.All) {
                Modular.to.pushNamed(ROUTE_ITEM_OVERV_VIEW);
              } else if (_servStore.totalFavoritesQtde() > 0) {
                Modular.to.pushNamed(ROUTE_ITEM_OVERV_FAV_VIEW);
              }
              _servStore.applyFilter(filterSelected, context);
            }),
        Badge(
            child: IconButton(
                icon: IOS_ICO_SHOP,
                onPressed: () {
                  Navigator.pushNamed(context, ROUTE_CART);
                }),
            value: "10")
      ]),
      drawer: Drawwer(),
      body: Observer(builder: (BuildContext _) => GridProducts(_servStore.filteredProducts)),
    );
  }
}
