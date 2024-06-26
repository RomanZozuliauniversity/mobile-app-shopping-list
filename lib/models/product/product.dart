import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String uid;

  final String imageUrl;

  final String title;
  final String description;

  final double price;

  Product({
    required this.uid,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? uid,
    String? imageUrl,
    String? title,
    String? description,
    double? price,
  }) {
    return Product(
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }
}
