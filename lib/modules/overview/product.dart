class Product {
  // ignore: prefer_final_fields
  String id; // ignore: prefer_final_fields
  String title; // ignore: prefer_final_fields
  String description; // ignore: prefer_final_fields
  double price; // ignore: prefer_final_fields
  String  imageUrl; // ignore: prefer_final_fields
  bool isFavorite = false; // ignore: prefer_final_fields

  Product(
      [this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      // ignore: avoid_positional_boolean_parameters
      this.isFavorite = false]);
}
