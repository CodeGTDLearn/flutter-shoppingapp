import 'package:get/get.dart';

import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../managed_products/entities/product.dart';
import '../../pages_generic_components/custom_snackbar.dart';
import '../components/filter_favorite_enum.dart';
import '../core/messages_snackbars_provided.dart';
import '../service/i_overview_service.dart';

class OverviewController extends GetxController {
  IOverviewService service;
  var filteredProductsObs = <Product>[].obs;
  var favoriteStatusObs = false.obs;

  OverviewController(this.service);

  @override
  void onInit() {
    service.clearDataSavingLists();
    getProducts().then((response) => filteredProductsObs.value = response);
    super.onInit();
  }

  @override
  void getProductsByFilter(EnumFilter filter) {
    filteredProductsObs.value = (filter == EnumFilter.Fav)
        ? service.getProductsByFilter(EnumFilter.Fav)
        : service.getProductsByFilter(EnumFilter.All);
  }

  @override
  void toggleFavoriteStatus(String id) {
    // @formatter:off
    var _previousFavoriteStatus = getProductById(id).isFavorite;
    service
        .toggleFavoriteStatus(id)
        .then((favoriteStatus) {
            if (_previousFavoriteStatus == favoriteStatus) {
              CustomSnackBar.simple(OPS, TOGGLE_STATUS_ERROR);
            } else {
              favoriteStatusObs.value = favoriteStatus;
              CustomSnackBar.simple(SUCESS, TOGGLE_STATUS_SUCESS);
            }
        });
    //favoriteStatusObs.value = getProductById(id).isFavorite;
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
}
