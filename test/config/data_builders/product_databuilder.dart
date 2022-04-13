import 'dart:math';

import 'package:faker/faker.dart';
import 'package:shopingapp/app/modules/inventory/entity/product.dart';

import '../app_tests_properties.dart';

class ProductDataBuilder {
  final _randomPosition = Random().nextInt(TEST_IMAGE_URL_MAP.length);

  Product ProductWithId() {
    return Product(
      id: Faker().randomGenerator.string(3, min: 2),
      title: Faker().food.dish(),
      description: Faker().food.cuisine(),
      price: num.parse(Faker().randomGenerator.decimal().toStringAsFixed(2)).toDouble(),
      imageUrl: TEST_IMAGE_URL_MAP.values.elementAt(_randomPosition),
      isFavorite: true,
      stockQtde: Random().nextInt(15) + 1,
      discount:
          double.parse((Random().nextDouble() * Random().nextInt(45)).toStringAsFixed(2)),
    );
  }

  Product ProductWithoutId() {
    return Product(
      title: '${Random().nextInt(9).toString()} Red Tomatoes',
      description: "The best Red tomatoes ever.",
      price: num.parse(Faker().randomGenerator.decimal().toStringAsFixed(2)).toDouble(),
      imageUrl: TEST_IMAGE_URL_MAP.values.elementAt(0),
      isFavorite: false,
      stockQtde: Random().nextInt(15) + 1,
      discount: double.parse((Random().nextDouble() * Random().nextInt(45)).toStringAsFixed(2)),
    );
  }

  Product ProductWithoutId_imageMap() {
    var random = Random();
    var _title = TEST_IMAGE_URL_MAP.keys.elementAt(_randomPosition);
    var _url = TEST_IMAGE_URL_MAP.values.elementAt(_randomPosition);

    var _qtde = random.nextInt(15);
    var _price = double.parse((random.nextDouble() * 99.99).toStringAsFixed(2));
    var _descript = """The best $_title ever! Wonderful product.""";

    return Product(
      title: _title,
      description: _descript,
      price: _price,
      imageUrl: _url,
      isFavorite: false,
      stockQtde: _qtde,
      discount: double.parse((Random().nextDouble() * Random().nextInt(45)).toStringAsFixed(2)),
    );
  }
}