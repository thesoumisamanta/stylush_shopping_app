class ProductsModel {
  final int id;
  final String? title;
  final String? category;
  final String? thumbnail;
  final List<String>? images;
  final double? price;
  final double? discountPercentage;

  ProductsModel({
    required this.id,
    this.title,
    this.category,
    this.thumbnail,
    this.images,
    this.price,
    this.discountPercentage
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
      price: json['price'],
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
    );
  }
}
