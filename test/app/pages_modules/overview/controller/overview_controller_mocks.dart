import 'package:mockito/mockito.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:shopingapp/app/pages_modules/overview/components/filter_favorite_enum.dart';
import 'package:shopingapp/app/pages_modules/overview/controller/i_overview_controller.dart';
import 'package:shopingapp/app/pages_modules/overview/service/i_overview_service.dart';

import '../utils/mock_data.dart';

class PredefinedMockController implements IOverviewController {


  @override
  void onInit() {
    // TODO: implement onInit
  }

  @override
  void toggleFavoriteStatus(String id) {
    // TODO: implement toggleFavoriteStatus
  }

  @override
  void getProductsByFilter(EnumFilter filter) {
    // estado
  }

  @override
  int getFavoritesQtde() {
    return MockData().favoritesProducts().length;
  }

  @override
  Product getProductById(String id) {
    return MockData().productById(id);
  }

  @override
  Future<List<Product>> getProducts() {
    return Future.value(MockData().products());
  }

  @override
  int getProductsQtde() {
    return MockData().products().length;
  }
}


class CustomMockController extends Mock implements IOverviewController {}
