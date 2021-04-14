import '../../inventory/entities/product.dart';

abstract class IOverviewRepo {
  Future<List<Product>> getProducts();

  Future<int> updateProduct({int id=1}, Product product);
}
