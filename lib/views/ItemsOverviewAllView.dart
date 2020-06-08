import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../components/appbarBadgeShopCart.dart';
import '../components/appbarPopupMenu.dart';
import '../components/drawwer.dart';
import '../components/gridProducts.dart';
import '../config/titlesIconsMessages/views/itemOverviewView.dart';
import '../enum/itemOverviewPopup.dart';
import '../services/itemsOverviewGridProductsStore.dart';

class ItemsOverviewAllView extends StatefulWidget {
  @override
  _ItemsOverviewAllViewState createState() => _ItemsOverviewAllViewState();
}

class _ItemsOverviewAllViewState extends State<ItemsOverviewAllView> {
  final _store = Modular.get<ItemsOverviewGridProductsStoreInt>();

  @override
  void initState() {
    _store.applyFilter(ItemsOverviewPopup.All, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(IOV_APPBAR_ALL_TIT), actions: [
          AppbarPopupMenu(allOption: false, favoriteOption: true),
          AppbarBadgeShopCart()
        ]),
        drawer: Drawwer(),
        body: Observer(
          builder: (BuildContext _) => GridProducts(_store.filteredProducts),
        ));
  }
}
