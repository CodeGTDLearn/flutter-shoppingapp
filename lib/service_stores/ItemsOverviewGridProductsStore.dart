import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/config/appProperties.dart';
import 'package:shopingapp/config/titlesIcons.dart';
import 'package:shopingapp/widgets/flushNotifier.dart';

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

  @observable
  String pageTitle;

  @action
  void applyFilter(ItemsOverviewPopup filter, BuildContext context) {
    if (filter == ItemsOverviewPopup.Favorites && totalFavoritesQtde() != 0) {
      filteredProducts = _repo.getFavorites();
    } else if (filter == ItemsOverviewPopup.All && totalItemsQtde() != 0) {
      filteredProducts = _repo.getAll();
    } else if (filter == ItemsOverviewPopup.Favorites && totalFavoritesQtde() == 0) {
      FlushNotifier(FLBAR_TIT_NOFAV, FLBAR_MSG_NOFAV, FLBAR_TIME, context).show();
    } else if (filter == ItemsOverviewPopup.All && totalItemsQtde() == 0) {
      FlushNotifier(FLBAR_TIT_DBEMPTY, FLBAR_MSG_DBEMPTY, FLBAR_TIME, context).show();
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
