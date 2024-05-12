import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_app/models/cart/cart_item.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  final String uuid;

  final List<CartItem> items;

  Cart({
    required this.uuid,
    required this.items,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
