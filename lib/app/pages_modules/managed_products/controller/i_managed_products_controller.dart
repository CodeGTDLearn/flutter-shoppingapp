import 'package:get/get.dart';

import '../entities/product.dart';
import '../service/i_managed_products_service.dart';

abstract class IManagedProductsController  {

  Future<List<Product>> getProducts();

  int managedProductsQtde();

  Product getProductById(String id);

  Future<void> addProduct(Product product);

  Future<int> updateProduct(Product product);

  Future<int> deleteProduct(String id);

  void reloadManagedProductsAddEditPage();

  void reloadManagedProductsObs();
}

