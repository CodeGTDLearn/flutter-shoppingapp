import 'package:get/get.dart';
import 'package:shopingapp/app/pages_modules/overview/core/messages_snackbars_provided.dart';
import 'package:shopingapp/app/pages_modules/pages_generic_components/custom_snackbar.dart';
import 'package:shopingapp/app/texts_icons_provider/app_generic_words.dart';

import '../../managed_products/entities/product.dart';
import '../components/filter_favorite_enum.dart';
import '../service/i_overview_service.dart';

class OverviewController extends GetxController {
  final IOverviewService _service = Get.find();

  var favoriteStatusObs = false.obs;
  var filteredProductsObs = <Product>[].obs;

  @override
  void onInit() {
    _service.clearDataSavingLists();
    getProducts().then((response) => filteredProductsObs.value = response);
  }

  void getProductsByFilter(EnumFilter filter) {
    filteredProductsObs.value = (filter == EnumFilter.Fav)
        ? _service.getProductsByFilter(EnumFilter.Fav)
        : _service.getProductsByFilter(EnumFilter.All);
  }

  Future<List<Product>> getProducts() {
    return _service.getProducts().then((response) => response);
  }

  int getFavoritesQtde() {
    return _service.getFavoritesQtde();
  }

  int getProductsQtde() {
    return _service.getProductsQtde();
  }

  Product getProductById(String id) {
    return _service.getProductById(id);
  }

  void toggleFavoriteStatus(String id) {
    var _previousFavoriteStatus = getProductById(id).isFavorite;
    _service.toggleFavoriteStatus(id).then((favoriteStatus) {
      favoriteStatusObs.value = favoriteStatus;
      if (_previousFavoriteStatus == favoriteStatus) {
        CustomSnackBar.simple(OPS, TOGGLE_STATUS_ERROR);
      } else {
        CustomSnackBar.simple(OPS, TOGGLE_STATUS_SUCESS);
      }
    });
    favoriteStatusObs.value = getProductById(id).isFavorite;
  }
}