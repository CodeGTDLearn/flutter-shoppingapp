import 'package:get/get.dart';

import '../../managed_products/entities/product.dart';
import '../components/popup_appbar_enum.dart';
import '../repo/i_overview_repo.dart';
import 'i_overview_service.dart';

class OverviewService implements IOverviewService {
  final IOverviewRepo _repo = Get.find();

  @override
  Future<List<Product>> getProducts() {
    return _repo.getProducts();
  }

  @override
  Future<List<Product>> getProductsByFilter(Popup filter) {
    if (filter == Popup.Fav) {
      return _repo.getFavoritesQtde() != 0
          ? _repo.getFavorites().then((response) => response)
          : [];
    }
    return _repo.getProductsQtde() == 0
        ? []
        : _repo.getProducts().then((response) => response);
  }

  @override
  int qtdeFavorites() {
    return _repo.getFavoritesQtde();
  }

  @override
  int qtdeProducts() {
    return _repo.getProductsQtde();
  }
}
