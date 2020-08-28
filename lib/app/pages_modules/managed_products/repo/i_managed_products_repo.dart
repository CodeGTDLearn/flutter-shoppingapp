import '../entities/product.dart';

abstract class IManagedProductsRepo {
  Future<List<Product>> getProducts();

  List<Product> get dataSavingProducts;

//  Future<Product> getManagedProductById(String id);
  Product getProductById(String id);

  Future<void> saveProduct(Product product);

  Future<void> updateProduct(Product product);

  Future<int> deleteProduct(String id);

  void clearDataSavingLists();
}
