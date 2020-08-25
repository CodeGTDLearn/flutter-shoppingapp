import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../components/popup_appbar_enum.dart';
import '../service/i_overview_service.dart';

class OverviewController extends GetxController {
  final IOverviewService _service = Get.find();

  var favoriteStatus = false.obs;
  var filteredProducts = <Product>[].obs;
  bool hasFavorites;

  @override
  void onInit() {
    filteredProducts.value = [];
    getOverviewProducts().then((value) => filteredProducts.value = value);
  }

  void getProductsByFilter(Popup enumFilter) {
    if (enumFilter == Popup.Fav) {
      filteredProducts.value = _service.getProductsByFilter(Popup.Fav);
      hasFavorites = filteredProducts.length != 0 ? true : false;
    } else {
      filteredProducts.value = _service.getProductsByFilter(Popup.All);
    }
  }

  Future<List<Product>> getOverviewProducts() {
    return _service.getOverviewProducts().then((response) {
      return response;
    });
  }

  int getOverviewFavoritesQtde() {
    return _service.getOverviewFavoritesQtde();
  }

  int getOverviewProductsQtde() {
    return _service.getOverviewProductsQtde();
  }

}

//void getProductsByFilter(Popup filter) {
//  if (filter == Popup.Fav) {
//    _service
//        .getProductsByFilter(Popup.Fav)
//        .then((response) => filteredProducts.value = response)
//        .catchError((onError) => onError);
//    hasFavorites = filteredProducts.length != 0 ? true : false;
//  } else {
//    _service
//        .getProductsByFilter(Popup.All)
//        .then((allProductsListResponse) =>
//    filteredProducts.value = allProductsListResponse)
//        .catchError((onError) => onError);
//  }
//}
