import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:shopingapp/entities_models/product.dart';
import 'package:shopingapp/repositories/i_products_repo.dart';

part 'grid_products_serv_store.g.dart';

class GridProductsServStore = IGridProductServStore with _$GridProductsServStore;

abstract class IGridProductServStore with Store {

  final _repo = Modular.get<IProductsRepo>();

  List<Product> gridViewProducts(int _showOnlyFavorites){
    return _showOnlyFavorites == 0 ? _repo.getFavorites() : _repo.getAll();
  }

}
