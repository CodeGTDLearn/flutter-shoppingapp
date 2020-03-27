import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../entities_models/product.dart';
import '../enum/itemOverviewPopup.dart';
import '../repositories/i_products_repo.dart';

part 'ItemsOverviewGridProductsStore.g.dart';

class ItemsOverviewGridProductsStore = IItemsOverviewGridProductsStore with _$ItemsOverviewGridProductsStore;

abstract class IItemsOverviewGridProductsStore with Store {
  final _repo = Modular.get<IProductsRepo>();

  @observable
  List<Product> filteredProducts = [];

  @action
  void applyFilter(ItemsOverviewPopup filterSelected) {
    if (filterSelected == ItemsOverviewPopup.Favorites) {
      this.filteredProducts = _repo.getFavorites();
    } else {
      this.filteredProducts = _repo.getAll();
    }
  }
}
