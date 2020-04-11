import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/repositories/i_products_repo.dart';

part 'ItemsOverviewGridProductItemStore.g.dart';

class ItemsOverviewGridProductItemStore = IItemsOverviewGridProductItemStore
    with _$ItemsOverviewGridProductItemStore;

abstract class IItemsOverviewGridProductItemStore with Store {
  final _repo = Modular.get<IProductsRepo>();

  @observable
  bool favoriteStatus;

  @action
  void toggleFavoriteStatus(String id) {
    _repo.toggleFavoriteStatus(id);
    favoriteStatus = _repo.getById(id).isFavorite;
  }

  Product getById(String id){
    return _repo.getById(id);
  }
}
