import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/widgets/flushNotifier.dart';

import '../entities_models/Product.dart';
import '../enum/itemOverviewPopup.dart';
import '../repositories/ProductsRepoInt.dart';

part 'ItemsOverviewGridProductsStore.g.dart';

class ItemsOverviewGridProductsStore = ItemsOverviewGridProductsStoreInt
    with _$ItemsOverviewGridProductsStore;

abstract class ItemsOverviewGridProductsStoreInt with Store {
  final _repo = Modular.get<ProductsRepoInt>();

  @observable
  List<Product> filteredProducts = [];

  @observable
  String pageTitle;

  @action
  void applyFilter(ItemsOverviewPopup filter, BuildContext context) {
    if (filter == ItemsOverviewPopup.Favorites && totalFavoritesQtde() != 0) {
      filteredProducts = _repo.getFavorites();
    } else if (filter == ItemsOverviewPopup.All && totalItemsQtde() != 0) {
      filteredProducts = _repo.getAll();
    } else if (filter == ItemsOverviewPopup.Favorites && totalFavoritesQtde() == 0) {
      FlushNotifier(FLB_TIT_SORRY, FLB_MSG_NOFAV, FLB_TIME, context).show();
    } else if (filter == ItemsOverviewPopup.All && totalItemsQtde() == 0) {
      FlushNotifier(FLB_TIT_OPS, FLB_MSG_DBEMPTY, FLB_TIME, context).show();
    }

    //pageTitle = filter == ItemsOverviewPopup.Favorites ? IOS_APPBAR_FAV_TITLE : IOS_APPBAR_TITLE;
  }

  int totalFavoritesQtde() {
    return _repo.getFavorites().length;
  }

  int totalItemsQtde() {
    return _repo.getAll().length;
  }

//  void flushNotifier(String title, String message, int time, BuildContext context) {
//    Flushbar(
//      title: title,
//      message: message,
//      duration: Duration(milliseconds: time),
//      icon: IOS_ICO_FAV_NOTIF,
//      shouldIconPulse: true,
//    ).show(context);
//  }
}
