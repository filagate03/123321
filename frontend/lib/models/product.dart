class Product {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final double price;
  final int? weightGrams;
  final String? imageUrl;
  final int? cookingTimeMinutes;
  final bool isPopular;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
    this.weightGrams,
    this.imageUrl,
    this.cookingTimeMinutes,
    this.isPopular = false,
  });

  // A factory constructor for creating a new Product instance from a map.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      weightGrams: json['weight_grams'],
      imageUrl: json['image_url'],
      cookingTimeMinutes: json['cooking_time_minutes'],
      isPopular: json['is_popular'] ?? false,
    );
  }
}
