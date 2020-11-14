import 'package:faker/faker.dart';
import 'package:shopingapp/app/pages_modules/managed_products/entities/product.dart';

class ProductDataBuilder {
  Product ProductId({String id}) {
    return Product(Faker().randomGenerator.string(3, min: 2));
  }

  Product ProductFull() {
    return Product(
        Faker().randomGenerator.string(3, min: 2),
        Faker().food.dish(),
        Faker().food.cuisine(),
        22.22,
        "https://images.freeimages"
        ".com/images/large-previews/eae/clothes-3-1466560.jpg",
        true
        // Faker().randomGenerator.boolean()
        );
  }
}
