import 'package:json_annotation/json_annotation.dart';

import 'package:mobile_app/models/product/product.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  final String uid;

  int count;

  final Product product;

  CartItem({
    required this.uid,
    required this.count,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
