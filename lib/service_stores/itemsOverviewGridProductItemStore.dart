import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/repositories/productsRepoInt.dart';

part 'itemsOverviewGridProductItemStore.g.dart';

class ItemsOverviewGridProductItemStore = ItemsOverviewGridProductItemStoreInt
    with _$ItemsOverviewGridProductItemStore;

abstract class ItemsOverviewGridProductItemStoreInt with Store {
  final _repo = Modular.get<ProductsRepoInt>();

  @observable
  bool favoriteStatus;

  @action
  void toggleFavoriteStatus(String id) {
    _repo.toggleFavoriteStatus(id);
    favoriteStatus = _repo.getById(id).get_isFavorite();
  }

  Product getById(String id){
    return _repo.getById(id);
  }
}
