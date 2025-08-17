class FakeStoreModel {
  final int id;
  final String? title;
  final String? description;
  final double? price;
  final String? image;
  final String? category;
  final double? rating;
  final int? ratingCount;

  FakeStoreModel({
    required this.id,
    this.title,
    this.description,
    this.price,
    this.category,
    this.image,
    this.rating,
    this.ratingCount,
  });

  factory FakeStoreModel.fromJson(Map<String, dynamic> json) {
    return FakeStoreModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      category: json['category'],
      rating: (json['rating']['rate'] as num).toDouble(),
      ratingCount: json['rating']['count'],
    );
  }
}
