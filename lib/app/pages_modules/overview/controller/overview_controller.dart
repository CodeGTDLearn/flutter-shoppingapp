import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';
import '../service/i_overview_service.dart';

class OverviewController extends GetxController {
  final IOverviewService service;
  var filteredProductsObs = <Product>[].obs;
  var favoriteStatusObs = false.obs;

  OverviewController({this.service});

  @override
  void onInit() {
    service.clearDataSavingLists();
    getProducts().then((response) => filteredProductsObs.assignAll(response));
    super.onInit();
  }

  void updateFilteredProductsObs() {
    filteredProductsObs.assignAll(service.getLocalDataAllProducts);
  }

  void getProductsByFilter(EnumFilter filter) {
    filteredProductsObs.assignAll(filter == EnumFilter.Fav
        ? service.getProductsByFilter(EnumFilter.Fav)
        : service.getProductsByFilter(EnumFilter.All));
  }

  Future<bool> toggleFavoriteStatus(String id) {
    // @formatter:off
    var _previousFavStatus = getProductById(id).isFavorite;
    var futureReturn = service
        .toggleFavoriteStatus(id)
        .then((returnedFavStatus) {
                if (_previousFavStatus != returnedFavStatus){
                  favoriteStatusObs.value = returnedFavStatus;
                }else{
                  return false;
                }
          return true;
        });
    favoriteStatusObs.value = getProductById(id).isFavorite;
    return futureReturn;
    // @formatter:on
  }

  Product getProductById(String id) {
    return service.getProductById(id);
  }

  Future<List<Product>> getProducts() {
    return service.getProducts().then((response) => response);
  }

  int getFavoritesQtde() {
    return service.getFavoritesQtde();
  }

  int getProductsQtde() {
    return service.getProductsQtde();
  }

  bool getFavoriteStatusObs() {
    return favoriteStatusObs.value;
  }

  List<Product> getFilteredProductsObs() {
    return filteredProductsObs.toList();
  }
}
