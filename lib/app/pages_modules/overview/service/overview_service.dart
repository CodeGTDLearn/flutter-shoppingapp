import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../components/popup_appbar_enum.dart';
import '../repo/i_overview_repo.dart';
import 'i_overview_service.dart';

class OverviewService implements IOverviewService {
  final IOverviewRepo _repo = Get.find();

  @override
  Future<List<Product>> getOverviewProducts() {
    return _repo.getOverviewProducts().then((response) {
      return response;
    });
  }

  @override
  Future<bool> toggleFavoriteStatus(String id){
    return _repo.toggleFavoriteStatus(id).then((bool) => bool);
  }

  @override
  List<Product> getProductsByFilter(Popup filter) {
    if (filter == Popup.Fav) {
      return getOverviewFavoritesQtde() == 0
          ? []
          : _repo.dataSavingListOverviewFavoritesProducts;
    }
    return getOverviewProductsQtde() == 0
        ? []
        : _repo.dataSavingListOverviewProducts;
  }

  @override
  int getOverviewFavoritesQtde() {
    return _repo.dataSavingListOverviewFavoritesProducts.length;
  }

  @override
  int getOverviewProductsQtde() {
    return _repo.dataSavingListOverviewProducts.length;
  }

  Future<Product> getOverviewProductById(String id){
    return _repo.getOverviewProductById(id).then((response) => response);
  }
}
