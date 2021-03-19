import '../entities/product.dart';

abstract class IManagedProductsService {
  Future<List<Product>> getProducts();

  int managedProductsQtde();

  List<Product> getLocalDataManagedProducts();

  Product getProductById(String id);

  Future<Product> addProduct(Product product);

  void addLocalDataManagedProducts(Product product);

  Future<int> updateProduct(Product product);

  Future<int> deleteProduct(String id);

  void clearDataSavingLists();
}
