import 'package:shopingapp/app/modules/inventory/entity/product.dart';

List<Product> PRODUCTS = [
  Product(
    id: 'p1',
    title: 'Red Shirt',
    description: 'A red shirt - it is pretty red!',
    price: 29.99,
    imageUrl: 'https://images.freeimages'
        '.com/images/large-previews/eae/clothes-3-1466560.jpg',
    stockQtde: 10,
  ),
  Product(
    id: 'p2',
    title: 'Trousers',
    description: 'A nice pair of trousers.',
    price: 59.99,
    imageUrl: 'https://upload.wikimedia'
        '.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    stockQtde: 10,
  ),
  Product(
    id: 'p3',
    title: 'Yellow Scarf',
    description: 'Warm and cozy - exactly what you need for the winter.',
    price: 19.99,
    imageUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    stockQtde: 10,
  ),
  Product(
    id: 'p4',
    title: 'A Pan',
    description: 'Prepare any meal you want.',
    price: 49.99,
    imageUrl: 'https://upload.wikimedia'
        '.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    stockQtde: 10,
  ),
];