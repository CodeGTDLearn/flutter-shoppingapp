import 'package:faker/faker.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

import '../app_tests_config.dart';

class ProductDataBuilder {
  Product ProductId({String id}) {
    return Product(id: Faker().randomGenerator.string(3, min: 2));
  }

  Product ProductFull() {
    return Product(
      id: Faker().randomGenerator.string(3, min: 2),
      title: Faker().food.dish(),
      description: Faker().food.cuisine(),
      price: Faker().randomGenerator.decimal(),
      imageUrl: "https://images.freeimages"
          ".com/images/large-previews/eae/clothes-3-1466560.jpg",
      isFavorite: true,
    );
  }

  Product ProductFullStaticNoId() {
    return Product(
      // id: Faker().randomGenerator.string(3, min: 2),
      title: 'Red Tomatoes',
      description: "The best Red tomatoes ever.",
      price: 99.99,
      imageUrl: IMAGE1_TEST_URL,
      isFavorite: false,
    );
  }
}
