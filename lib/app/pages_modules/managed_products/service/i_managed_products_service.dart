import '../entities/product.dart';

abstract class IManagedProductsService {
  Future<List<Product>> getAllManagedProducts();

  int managedProductsQtde();

//  List<Product> getAllOptimisticList();

//  Future<Product> getByIdManagedProduct(String id);
  Product getByIdManagedProduct(String id);

  Future<void> saveManagedProduct(Product product);

  Future<void> updateManagedProduct(Product product);

  Future<int> deleteManagedProduct(String id);
}
