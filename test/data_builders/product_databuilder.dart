import 'dart:math';

import 'package:faker/faker.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

import '../config/tests_config.dart';

class ProductDataBuilder {
  final _randomPosition = Random().nextInt(TEST_IMAGE_URL_MAP.length);

  Product ProductWithId() {
    return Product(
      id: Faker().randomGenerator.string(3, min: 2),
      title: Faker().food.dish(),
      description: Faker().food.cuisine(),
      price: num.parse(Faker().randomGenerator.decimal().toStringAsFixed(2)).toDouble(),
      imageUrl: "https://images.freeimages"
          ".com/images/large-previews/eae/clothes-3-1466560.jpg",
      isFavorite: true,
    );
  }

  Product ProductWithoutId() {
    return Product(
      title: '${Random().nextInt(9).toString()} Red Tomatoes',
      description: "The best Red tomatoes ever.",
      price: 99.99,
      imageUrl: TEST_IMAGE_URL_MAP.values.elementAt(0),
      isFavorite: false,
    );
  }

  Product ProductWithoutId_imageMap() {
    var _title = TEST_IMAGE_URL_MAP.keys.elementAt(_randomPosition);
    var _url = TEST_IMAGE_URL_MAP.values.elementAt(_randomPosition);

    return Product(
      title: _title,
      description: "The best Description Product ever.",
      price: 99.99,
      imageUrl: _url,
      isFavorite: false,
    );
  }
}
