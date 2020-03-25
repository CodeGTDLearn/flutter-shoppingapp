import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/enum/itemOverviewPopup.dart';
import 'package:shopingapp/repositories/i_products_repo.dart';

part 'items_overview_serv_store.g.dart';

class ItemsOverviewServStore = IItemsOverviewServStore with _$ItemsOverviewServStore;

abstract class IItemsOverviewServStore with Store {
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

  void toggleFavoriteStatus (String id){
    _repo.toggleFavoriteStatus(id);
  }

  bool getFavoriteStatus(String id){
    return _repo.getById(id).isFavorite;
  }

}
