import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons/flushbarNotifications.dart';
import 'package:shopingapp/widgets/flushNotifier.dart';

import '../entities_models/product.dart';
import '../enum/itemOverviewPopup.dart';
import '../repositories/productsRepoInt.dart';

part 'itemsOverviewGridProductsStore.g.dart';

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
      FlushNotifier(SORRY, MSG_NOFAV, FLSH_TIME, context).simple();
    } else if (filter == ItemsOverviewPopup.All && totalItemsQtde() == 0) {
      FlushNotifier(OPS, MSG_DATA, FLSH_TIME, context).simple();
    }

    //pageTitle = filter == ItemsOverviewPopup.Favorites ? IOS_APPBAR_FAV_TITLE : IOS_APPBAR_TITLE;
  }

  int totalFavoritesQtde() {
    return _repo.getFavorites().length;
  }

  int totalItemsQtde() {
    return _repo.getAll().length;
  }
}
