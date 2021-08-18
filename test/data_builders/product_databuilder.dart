import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:shopingapp/app/modules/inventory/entities/product.dart';

import '../config/tests_config.dart';

class ProductDataBuilder {
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
      imageUrl: IMAGE1_TEST_URL,
      isFavorite: false,
    );
  }

  Product ProductWithoutIdCustomUrlImage({required int position_From1_To4}) {
    var list = [
      IMAGE1_TEST_URL,
      IMAGE2_TEST_URL,
      IMAGE3_TEST_URL,
      IMAGE4_TEST_URL,
      IMAGE5_TEST_URL,
    ];

    return Product(
      title: '${Random().nextInt(9).toString()} Red Tomatoes',
      description: "The best Red tomatoes ever.",
      price: 99.99,
      // imageUrl: IMAGE1_TEST_URL,
      imageUrl: list[position_From1_To4],
      isFavorite: false,
    );
  }
}
