import 'package:get/get.dart';

import '../../../core/texts_icons_provider/app_generic_words.dart';
import '../../managed_products/entities/product.dart';
import '../../pages_generic_components/custom_snackbar.dart';
import '../components/filter_favorite_enum.dart';
import '../core/messages_snackbars_provided.dart';
import '../service/i_overview_service.dart';

abstract class IOverviewController{

  void onInit();

  void getProductsByFilter(EnumFilter filter);

  Future<List<Product>> getProducts();

  int getFavoritesQtde();

  int getProductsQtde();

  Product getProductById(String id);

  void toggleFavoriteStatus(String id);
}