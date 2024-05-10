import 'dart:convert';

import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/repositories/cart/interface/i_cart_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const _cartPrefixKey = 'cart-';

class LocalCartRepo implements ICartRepo {
  const LocalCartRepo();

  @override
  Future<void> addCartItem({
    required String uuid,
    required Product product,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    var itemsJson =
        sharedPreferences.getStringList('$_cartPrefixKey-$uuid') ?? [];
    final items = itemsJson
        .map((e) => CartItem.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();

    final index = items.indexWhere((e) => e.product.uid == product.uid);
    if (index >= 0) {
      items[index].count++;
    } else {
      items.add(CartItem(uid: const Uuid().v4(), count: 1, product: product));
    }

    itemsJson = items.map((e) => jsonEncode(e.toJson())).toList();

    await sharedPreferences.setStringList('$_cartPrefixKey-$uuid', itemsJson);
  }

  @override
  Future<List<CartItem>> fetchCartItems({required String uuid}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final itemsJson =
        sharedPreferences.getStringList('$_cartPrefixKey-$uuid') ?? [];
    return itemsJson
        .map((e) => CartItem.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> removeCartItem({
    required String uuid,
    required CartItem item,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    var itemsJson =
        sharedPreferences.getStringList('$_cartPrefixKey-$uuid') ?? [];
    final items = itemsJson
        .map((e) => CartItem.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();

    items.removeWhere((e) => e.uid == item.uid);
    itemsJson = items.map((e) => jsonEncode(e.toJson())).toList();

    await sharedPreferences.setStringList('$_cartPrefixKey-$uuid', itemsJson);
  }

  @override
  Future<void> updateCartItem({
    required String uuid,
    required CartItem item,
  }) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    var itemsJson =
        sharedPreferences.getStringList('$_cartPrefixKey-$uuid') ?? [];
    final items = itemsJson
        .map((e) => CartItem.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();

    final index = items.indexWhere((e) => e.uid == item.uid);

    if (index < 0) return;

    items[index] = item;

    itemsJson = items.map((e) => jsonEncode(e.toJson())).toList();

    await sharedPreferences.setStringList(
      '$_cartPrefixKey-$uuid',
      itemsJson,
    );
  }

  @override
  Future<void> clearCart({required String uuid}) async {
    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.remove('$_cartPrefixKey-$uuid');
  }
}
