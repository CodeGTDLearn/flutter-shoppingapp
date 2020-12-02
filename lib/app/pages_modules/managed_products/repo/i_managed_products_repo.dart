import '../entities/product.dart';

abstract class IManagedProductsRepo {
  Future<List<Product>> getProducts();

  Future<Product> addProduct(Product product);

  Future<int> updateProduct(Product product);

  Future<int> deleteProduct(String id);

}
