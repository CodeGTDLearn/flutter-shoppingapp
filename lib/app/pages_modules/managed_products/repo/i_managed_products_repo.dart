import '../entities/product.dart';

abstract class IManagedProductsRepo {
  Future<List<Product>> getAllManagedProducts();

  int getManagedProductsQtde();

  Product getById(String id);

  Future<void> addProduct(Product product);

  bool update(Product product);

  void delete(String id);
}
