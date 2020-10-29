import 'package:faker/faker.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';
import 'package:test/test.dart';

class DataBuilder {
  String _id;
  String _title;
  String _description;
  double _price;
  String _imageUrl;
  bool _isFavorite = false;

  Product ProductId({String id}) {
    return Product(Faker().randomGenerator.string(3, min: 2));
  }

  Product ProductFull() {
    return Product(
      Faker().randomGenerator.string(3, min: 2),
      Faker().food.toString(),
      Faker().food.cuisine(),
      22.22,
      "https://images.freeimages"
          ".com/images/large-previews/eae/clothes-3-1466560.jpg",
      true
    );
  }
}
