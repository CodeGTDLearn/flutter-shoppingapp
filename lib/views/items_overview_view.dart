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
  List<ReactionDisposer> disposers;

  @override
  void initState() {
    _servStore.applyFilter(ItemsOverviewPopup.All);

    disposers = [
      autorun((r) {
        Flushbar(
          title: "Sorry...",
          message: "Favorites not found.",
          duration: Duration(milliseconds: 2000),
          icon: IOS_ICO_FAV_NOTIF,
          shouldIconPulse: true,
        ).show(context);


      })
    ];
    super.initState();
  }

  @override
  void dispose() {
    disposers.forEach((dispose) => dispose());
    super.dispose();
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

  void flushNotifier(String title, String message, int time) {
    Flushbar(
      title: title,
      message: message,
      duration: Duration(milliseconds: time),
      icon: IOS_ICO_FAV_NOTIF,
      shouldIconPulse: true,
    ).show(context);

//            Flushbar(
//            title: "Sorry...",
//            message: "Favorites not found.",
//            duration: Duration(milliseconds: 2000),
//            icon: IOS_ICO_FAV_NOTIF,
//            shouldIconPulse: true,
//          ).show(context);
  }
}

//        if (_servStore.getFavorites() == 0) {
//          flushNotifier("Sorry...", "Favorites not found.", 2000);
//        } else if (_servStore.getFavorites() != 0) {
//          flushNotifier(
//              "Awesome!", "You have favorites ${_servStore.getFavorites()}.", 2000);
//        } else {
//          flushNotifier("Opss...", "There is no products in stock.", 2000);
//        }
