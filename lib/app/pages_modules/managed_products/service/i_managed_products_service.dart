import '../entities/product.dart';

abstract class IManagedProductsService {
  Future<List<Product>> getAllManagedProducts();

  int managedProductsQtde();

  Product getById(String id);

  Future<void> addProduct(Product product);

  void update(Product product);

  void delete(String id);
}
