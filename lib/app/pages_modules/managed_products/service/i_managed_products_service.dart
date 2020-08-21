import '../entities/product.dart';

abstract class IManagedProductsService {
  Future<List<Product>> getAllManagedProducts();

  List<Product> getAllManagedProductsOptmistic();

  int managedProductsQtde();

  Future<Product> getByIdManagedProduct(String id);

  Future<void> saveManagedProduct(Product product);

  Future<void> updateManagedProduct(Product product);

  void deleteManagedProduct(String id);
}
