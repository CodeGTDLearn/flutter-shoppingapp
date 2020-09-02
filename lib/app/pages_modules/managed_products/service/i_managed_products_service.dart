import '../entities/product.dart';

abstract class IManagedProductsService {
  Future<List<Product>> getProducts();

  int managedProductsQtde();

  List<Product> get dataSavingProducts;

  Product getProductById(String id);

  Future<void> saveProduct(Product product);

  Future<int> updateProduct(Product product);

  Future<int> deleteProduct(String id);

  void clearDataSavingLists();

  void _orderDataSavingLists();
}
