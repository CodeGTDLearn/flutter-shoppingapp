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
  Future<bool> toggleOverviewProductFavoriteStatus(String id){
    _repo.toggleOverviewProductFavoriteStatus(id).then((bool) => bool);
  }

  @override
//  Future<List<Product>> getProductsByFilter(Popup filter) {
  List<Product> getProductsByFilter(Popup filter) {
    _repo.getOverviewProducts();
    if (filter == Popup.Fav) {
      return getOverviewFavoritesQtde() == 0
          ? []
          : _repo.dataSavingListOverviewFavoritesProducts;
//          ? _repo.getOverviewFavoriteProducts().then((response) => response)
    }
    return getOverviewProductsQtde() == 0
        ? []
        : _repo.dataSavingListOverviewProducts;
//        : _repo.getOverviewProducts().then((response) => response);
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
