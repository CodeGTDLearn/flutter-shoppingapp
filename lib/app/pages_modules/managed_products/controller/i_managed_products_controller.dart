import '../entities/product.dart';

abstract class IManagedProductsController {
  Future<List<Product>> getProducts();

  int managedProductsQtde();

  Product getProductById(String id);

  Future<Product> addProduct(Product product);

  Future<int> updateProduct(Product product);

  Future<int> deleteProduct(String id);

  void switchManagedProdAddEditFormToCustomCircularProgrIndic();

  void updateManagedProductsObs();

  List<Product> getManagedProductsObs();

  bool getReloadManagedProductsEditPageObs();
}
