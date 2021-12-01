import '../entity/product.dart';

abstract class IInventoryService {
  Future<List<Product>> getProducts();

  int getProductsQtde();

  List<Product> getLocalDataInventoryProducts();

  Product getProductById(String id);

  Future<Product> addProduct(Product product);

  void addLocalDataInventoryProducts(Product product);

  Future<int> updateProduct(Product product);

  Future<int> deleteProduct(String id);

  void clearDataSavingLists();
}