import '../../inventory/entity/product.dart';

abstract class IOverviewRepo {
  Future<List<Product>> getProducts();

  Future<int> updateProduct(Product product);
}
