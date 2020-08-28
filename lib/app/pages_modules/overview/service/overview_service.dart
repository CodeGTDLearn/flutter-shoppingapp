import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';
import '../repo/i_overview_repo.dart';
import 'i_overview_service.dart';

class OverviewService implements IOverviewService {
  final IOverviewRepo _repo = Get.find();

  @override
  Future<List<Product>> getProducts() {
    return _repo.getProducts().then((response) {
      return response;
    });
  }

  @override
  Future<bool> toggleFavoriteStatus(String id) {
    return _repo
        .toggleFavoriteStatus(id)
        .then((favoriteStatus) => favoriteStatus);
  }

  @override
  List<Product> getProductsByFilter(EnumFilter filter) {
    if (filter == EnumFilter.Fav) {
      return getFavoritesQtde() == 0 ? [] : _repo.dataSavingFavoritesProducts;
    }
    return getProductsQtde() == 0 ? [] : _repo.dataSavingAllProducts;
  }

  @override
  int getFavoritesQtde() {
    return _repo.dataSavingFavoritesProducts.length;
  }

  @override
  int getProductsQtde() {
    return _repo.dataSavingAllProducts.length;
  }

  @override
  Product getProductById(String id) {
    return _repo.getProductById(id);
  }

  @override
  void clearDataSavingLists() {
    _repo.clearDataSavingLists();
  }
}

// @override
// Future<Product> getProductById(String id) {
//   return _repo.getProductById(id).then((response) => response);
// }