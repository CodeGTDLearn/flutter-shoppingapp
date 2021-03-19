import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';
import '../service/i_overview_service.dart';
import 'i_overview_controller.dart';

class OverviewController extends GetxController implements IOverviewController {
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

  @override
  void updateFilteredProductsObs(){
    filteredProductsObs.assignAll(service.getLocalDataAllProducts);
  }

  @override
  void getProductsByFilter(EnumFilter filter) {
    filteredProductsObs.assignAll(filter == EnumFilter.Fav
        ? service.getProductsByFilter(EnumFilter.Fav)
        : service.getProductsByFilter(EnumFilter.All));
  }

  @override
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

  @override
  Product getProductById(String id) {
    return service.getProductById(id);
  }

  @override
  Future<List<Product>> getProducts() {
    return service.getProducts().then((response) => response);
  }

  @override
  int getFavoritesQtde() {
    return service.getFavoritesQtde();
  }

  @override
  int getProductsQtde() {
    return service.getProductsQtde();
  }

  @override
  bool getFavoriteStatusObs(){
    return favoriteStatusObs.value;
  }

  @override
  List<Product> getFilteredProductsObs (){
    return filteredProductsObs.toList();
  }
}
