import 'package:get/state_manager.dart';

import '../../inventory/entity/product.dart';
import '../core/overview_appbar/filter_options.dart';
import '../service/i_overview_service.dart';

class OverviewController extends GetxController {
  final IOverviewService service;

  //OVERVIEW VIEW -> OBSERVABLES
  var overviewViewGridViewItemsObs = <Product>[].obs;
  var favoriteStatusObs = false.obs;
  var appbarFilterPopupObs = FilterOptions.All.obs;

  //OVERVIEW-DETAILS -> OBSERVABLES
  var overviewItemDetailsImageZoomObs = false.obs;

  OverviewController({required this.service});

  @override
  void onInit() {
    service.clearDataSavingLists();
    getProducts().then((response) => overviewViewGridViewItemsObs.assignAll(response));
    super.onInit();
  }

  void updateFilteredProductsObs() {
    overviewViewGridViewItemsObs.assignAll(service.getLocalDataAllProducts());
  }

  void deleteProduct(String productId) {
    service.deleteProductInLocalDataLists(productId);
  }

  void applyPopupFilter(FilterOptions filter) {
    appbarFilterPopupObs.value = filter;

    overviewViewGridViewItemsObs.assignAll(filter == FilterOptions.Fav
        ? service.setProductsByFilter(FilterOptions.Fav)
        : service.setProductsByFilter(FilterOptions.All));
  }

  Future<bool> toggleFavoriteStatus(String id) {
    // @formatter:off
    var _previousStatus = getProductById(id).isFavorite;
    var futureReturn = service.toggleFavoriteStatus(id).then((returnedFavStatus) {
      if (_previousStatus != returnedFavStatus) {
        favoriteStatusObs.value = returnedFavStatus;
      } else {
        return false;
      }
      return true;
    });
    favoriteStatusObs.value = getProductById(id).isFavorite;
    return futureReturn;
    // @formatter:on
  }

  void toggleOverviewItemDetailsImageZoomObs() {
    overviewItemDetailsImageZoomObs.value = !overviewItemDetailsImageZoomObs.value;
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

}