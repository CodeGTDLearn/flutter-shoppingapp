import 'package:get/get.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/i_overview_controller.dart';

import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../managed_products/entities/product.dart';
import '../../pages_generic_components/custom_snackbar.dart';
import '../components/filter_favorite_enum.dart';
import '../core/messages_snackbars_provided.dart';
import '../service/i_overview_service.dart';

class OverviewController extends GetxController implements IOverviewController {
  final IOverviewService service = Get.find();

  var filteredProductsObs = <Product>[].obs;
  var favoriteStatusObs = false.obs;

  @override
  void onInit() {
    service.clearDataSavingLists();
    getProducts().then((response) => filteredProductsObs.value = response);
  }

  @override
  void getProductsByFilter(EnumFilter filter) {
    filteredProductsObs.value = (filter == EnumFilter.Fav)
        ? service.getProductsByFilter(EnumFilter.Fav)
        : service.getProductsByFilter(EnumFilter.All);
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
  Product getProductById(String id) {
    return service.getProductById(id);
  }

  @override
  void toggleFavoriteStatus(String id) {
    var _previousFavoriteStatus = getProductById(id).isFavorite;
    service.toggleFavoriteStatus(id).then((favoriteStatus) {
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
