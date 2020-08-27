import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../components/popup_appbar_enum.dart';
import '../service/i_overview_service.dart';

class OverviewController extends GetxController {
  final IOverviewService _service = Get.find();

  var favoriteStatus = false.obs;
  var filteredProducts = <Product>[].obs;
//  bool hasFavorites;

  @override
  void onInit() {
    filteredProducts.value = [];
    getOverviewProducts().then((value) => filteredProducts.value = value);
    print("ONINIT DO CONTROLLER");
  }

  void getProductsByFilter(Popup enumFilter) {
    var tempListProducts = <Product>[];
    if (enumFilter == Popup.Fav) {
      tempListProducts = _service.getProductsByFilter(Popup.Fav);
//      hasFavorites = filteredProducts.length != 0 ? true : false;
    } else {
      tempListProducts = _service.getProductsByFilter(Popup.All);
    }
    filteredProducts.value = tempListProducts;
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

  Product getOverviewProductById(String id) {
    _service.getOverviewProductById(id).then((product) => product);
  }

  void toggleFavoriteStatus(String id) {
    _service.toggleFavoriteStatus(id).then((bool) => favoriteStatus.value = bool);
  }
}
