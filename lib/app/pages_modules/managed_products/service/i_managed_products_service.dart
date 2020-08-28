import '../entities/product.dart';

abstract class IManagedProductsService {
  Future<List<Product>> getProducts();

  int managedProductsQtde();

//  List<Product> getAllOptimisticList();

//  Future<Product> getByIdManagedProduct(String id);
  Product getProductById(String id);

  Future<void> saveProduct(Product product);

  Future<void> updateProduct(Product product);

  Future<int> deleteProduct(String id);
}
