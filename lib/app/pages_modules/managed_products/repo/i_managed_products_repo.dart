import '../entities/product.dart';

abstract class IManagedProductsRepo {
  Future<List<Product>> getProducts();

  Future<Product> saveProduct(Product product);

  Future<int> updateProduct(Product product);

  Future<int> deleteProduct(String id);

}
