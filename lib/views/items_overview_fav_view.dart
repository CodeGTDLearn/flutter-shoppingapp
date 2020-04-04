import 'package:flushbar/flushbar.dart';
import 'package:shopingapp/service_stores/CartStore.dart';
import 'package:shopingapp/widgets/appbar_popup_menu.dart';
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

class ItemsOverviewFavView extends StatefulWidget {
  @override
  _ItemsOverviewViewState createState() => _ItemsOverviewViewState();
}

class _ItemsOverviewViewState extends State<ItemsOverviewFavView> {
  final _GridProductsServStore = Modular.get<IItemsOverviewGridProductsStore>();
  final _servCartStore = Modular.get<ICartStore>();

  @override
  void initState() {
    _GridProductsServStore.applyFilter(ItemsOverviewPopup.Favorites, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(IOS_APPBAR_FAV_TITLE), actions: [
        AppbarPopupMenu(allOption: true, favoriteOption: false),
        Observer(
            builder: (BuildContext _) => Badge(
                  child: IconButton(
                      icon: IOS_ICO_SHOP,
                      onPressed: () => Navigator.pushNamed(context, ROUTE_CART)),
                value: _servCartStore.totalCartItems))
      ]),
      drawer: Drawwer(),
      body: Observer(
          builder: (BuildContext _) => GridProducts(_GridProductsServStore.filteredProducts)),
    );
  }
}
