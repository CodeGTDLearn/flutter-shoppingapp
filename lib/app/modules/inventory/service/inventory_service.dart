import '../../cart/entity/cart_item.dart';
import '../../overview/service/i_overview_service.dart';
import '../entity/product.dart';
import '../repo/i_inventory_repo.dart';
import 'i_inventory_service.dart';

class InventoryService implements IInventoryService {
  final IInventoryRepo repo;

  final IOverviewService overviewService;
  List<Product> _localInventoryProducts = [];

  InventoryService({
    required this.repo,
    required this.overviewService,
  });

  @override
  Future<List<Product>> getProducts() {
    // @formatter:off
    return repo.getProducts()
               .then((products) {
                 clearDataSavingLists();
                 _localInventoryProducts = products;
                 _orderDataSavingLists();
                 return getLocalDataInventoryProducts();
               });
    // @formatter:on
  }

  @override
  int getProductsQtde() {
    return getLocalDataInventoryProducts().length;
  }

  @override
  Product getProductById(String id) {
    var _index = _localInventoryProducts.indexWhere((item) => item.id == id);
    return _localInventoryProducts[_index];
  }

  @override
  List<Product> getLocalDataInventoryProducts() {
    return [..._localInventoryProducts];
  }

  @override
  Future<Product> addProduct(Product _product) {
    // @formatter:off
    return repo.addProduct(_product).then((addedProduct) {
      addLocalDataInventoryProducts(addedProduct);
      overviewService.addProductInLocalDataAllProducts(addedProduct);
      return addedProduct;
    }).catchError((onError) => throw onError);
    // @formatter:on
  }

  @override
  void addLocalDataInventoryProducts(Product product) {
    _localInventoryProducts.add(product);
  }

  @override
  Future<int> updateProduct(Product product) {
    // @formatter:off
    final _index = _localInventoryProducts.indexWhere((item) => item.id == product.id);

    return repo.updateProduct(product).then((statusCode) {
      if (statusCode >= 200 && statusCode < 400) {
        _localInventoryProducts[_index] = product;
        overviewService.updateProductInLocalDataLists(product);
      }
      return statusCode;
    });
    // @formatter:on
  }

  @override
  Future<int> deleteProduct(String id) {
    // @formatter:off
    final _index = _localInventoryProducts.indexWhere((item) => item.id == id);

    var _rollbackDataSavingProducts = [..._localInventoryProducts];

    _localInventoryProducts.removeAt(_index);

    _orderDataSavingLists();

    return repo.deleteProduct(id).then((statusCode) {
      if (statusCode >= 400) {
        _localInventoryProducts = _rollbackDataSavingProducts;
        _orderDataSavingLists();
      }
      return statusCode;
    });
    // @formatter:oN
  }

  @override
  void clearDataSavingLists() {
    _localInventoryProducts = [];
  }

  @override
  bool checkItemAvailability(String id) {
    var _index = _localInventoryProducts.indexWhere((item) => item.id == id);
    var productFound = _index >= 0;
    if (productFound) return getProductById(id).stockQtde > 0;
    return false;
  }

  @override
  void updateStockItemsQuantity(Map<String, CartItem> cartItems) {
    var availableCartItems = <String, CartItem>{};
    cartItems.forEach((key, cartItem) {
      var product = getProductById(cartItem.id);
      product.stockQtde = product.stockQtde - cartItem.qtde;
      updateProduct(product);
    });
  }

  void _orderDataSavingLists() {
    _localInventoryProducts.toList().reversed;
  }
}