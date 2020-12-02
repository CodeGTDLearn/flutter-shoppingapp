import '../entities/product.dart';

abstract class IManagedProductsService {
  Future<List<Product>> getProducts();

  int managedProductsQtde();

  List<Product> get localDataManagedProducts;

  Product getProductById(String id);

  Future<void> addProduct(Product product);

  Future<int> updateProduct(Product product);

  Future<int> deleteProduct(String id);

  void clearDataSavingLists();
}
