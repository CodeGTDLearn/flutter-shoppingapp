import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../enum/itemOverviewPopup.dart';
import '../service_stores/ItemsOverviewGridProductsStore.dart';
import '../config/titlesIcons.dart';
import '../widgets/BadgeShopCartObserver.dart';
import '../widgets/drawwer.dart';
import '../widgets/gridProducts.dart';
import '../widgets/appbar_popup_menu.dart';

class ItemsOverviewView extends StatefulWidget {
  @override
  _ItemsOverviewViewState createState() => _ItemsOverviewViewState();
}

class _ItemsOverviewViewState extends State<ItemsOverviewView> {
  final _store = Modular.get<ItemsOverviewGridProductsStoreInt>();

  @override
  void initState() {
    _store.applyFilter(ItemsOverviewPopup.All, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(IOS_APPBAR_TIT), actions: [
          AppbarPopupMenu(allOption: false, favoriteOption: true),
          BadgeShopCartObserver()
        ]),
        drawer: Drawwer(),
        body: Observer(builder: (BuildContext _) => GridProducts(_store.filteredProducts)));
  }
}
