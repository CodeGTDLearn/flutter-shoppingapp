import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopingapp/enum/itemOverviewPopup.dart';
import 'package:shopingapp/service_stores/items_overview_serv_store.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/widgets/badge.dart';
import 'package:shopingapp/widgets/drawwer.dart';
import 'package:shopingapp/widgets/gridProducts.dart';

class ItemsOverviewView extends StatefulWidget {
  @override
  _ItemsOverviewViewState createState() => _ItemsOverviewViewState();
}

class _ItemsOverviewViewState extends State<ItemsOverviewView> {
  final _servStore = Modular.get<ItemsOverviewServStore>();

  @override
  void initState() {
    _servStore.applyFilter(ItemsOverviewPopup.All);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(IOS_APPBAR_TITLE), actions: [
        PopupMenuButton(
            itemBuilder: (_) => [
                  PopupMenuItem(
                      child: Text(IOS_TXT_POPUP_FAV), value: ItemsOverviewPopup.Favorites),
                  PopupMenuItem(child: Text(IOS_TXT_POPUP_ALL), value: ItemsOverviewPopup.All)
                ],
            onSelected: (filterSelected) => _servStore.applyFilter(filterSelected)),
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
