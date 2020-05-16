import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../entities/product.dart';
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
  bool hasFavorites;

  @action
  void applyFilter(ItemsOverviewPopup filter, BuildContext context) {
    if (filter == ItemsOverviewPopup.Favorites && qtdeFavorites() != 0) {
      filteredProducts = _repo.getFavorites();
      hasFavorites = true;
    } else if (filter == ItemsOverviewPopup.Favorites && qtdeFavorites() == 0) {
      hasFavorites = false;
    } else if (filter == ItemsOverviewPopup.All && qtdeItems() != 0) {
      filteredProducts = _repo.getAll();
    }
  }

  int qtdeFavorites() {
    return _repo.getFavorites().length;
  }

  int qtdeItems() {
    return _repo.getAll().length;
  }
}
