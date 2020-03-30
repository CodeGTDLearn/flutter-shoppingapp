import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/config/titlesIcons.dart';

import '../entities_models/product.dart';
import '../enum/itemOverviewPopup.dart';
import '../repositories/i_products_repo.dart';

part 'ItemsOverviewGridProductsStore.g.dart';

class ItemsOverviewGridProductsStore = IItemsOverviewGridProductsStore
    with _$ItemsOverviewGridProductsStore;

abstract class IItemsOverviewGridProductsStore with Store {
  final _repo = Modular.get<IProductsRepo>();

  @observable
  List<Product> filteredProducts = [];

  @action
  void applyFilter(ItemsOverviewPopup filter, BuildContext context) {
    if (filter == ItemsOverviewPopup.Favorites && totalFavoritesQtde() != 0) {
      filteredProducts = _repo.getFavorites();
    } else if (filter == ItemsOverviewPopup.All && totalItemsQtde() != 0) {
      filteredProducts = _repo.getAll();
    } else if (filter == ItemsOverviewPopup.Favorites && totalFavoritesQtde() == 0) {
      flushNotifier("Sorry...", "Favorites not found.", 2000, context);
    } else if (filter == ItemsOverviewPopup.All && totalItemsQtde() == 0) {
      flushNotifier("Ops...", "There is no item in database.", 2000, context);
    }
  }

  int totalFavoritesQtde() {
    return _repo.getFavorites().length;
  }

  int totalItemsQtde() {
    return _repo.getAll().length;
  }

  void flushNotifier(String title, String message, int time, BuildContext context) {
    Flushbar(
      title: title,
      message: message,
      duration: Duration(milliseconds: time),
      icon: IOS_ICO_FAV_NOTIF,
      shouldIconPulse: true,
    ).show(context);
  }
}
