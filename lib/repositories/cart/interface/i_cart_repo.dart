import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/models/product/product.dart';

abstract class ICartRepo {
  Future<List<CartItem>> fetchCartItems({required String uuid});

  Future<void> clearCart({required String uuid});

  Future<void> addCartItem({required String uuid, required Product product});
  Future<void> updateCartItem({required String uuid, required CartItem item});
  Future<void> removeCartItem({required String uuid, required CartItem item});
}
