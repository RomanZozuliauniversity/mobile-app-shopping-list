import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';

class CartController {
  User? _currentUser;

  Future<void> onClearCartTap({
    required ICartProvider cartProvider,
    required IUserProvider userProvider,
  }) async {
    _currentUser ??= await userProvider.fetchUser();

    if (_currentUser is! User) return;

    return cartProvider.clearCart(uuid: _currentUser!.uid);
  }

  Future<List<CartItem>> fetchCartItems({
    required ICartProvider cartProvider,
    required IUserProvider userProvider,
  }) async {
    _currentUser ??= await userProvider.fetchUser();

    if (_currentUser is! User) return [];

    return cartProvider.fetchCartItems(uuid: _currentUser!.uid);
  }

  Future<void> onDecreaseTap({
    required CartItem item,
    required ICartProvider cartProvider,
    required IUserProvider userProvider,
  }) async {
    _currentUser ??= await userProvider.fetchUser();

    if (_currentUser is! User) return;

    if (item.count - 1 > 0) {
      item.count--;
      cartProvider.updateCartItem(uuid: _currentUser!.uid, item: item);
    } else {
      cartProvider.removeCartItem(uuid: _currentUser!.uid, item: item);
    }
  }

  Future<void> onIncreaseTap({
    required CartItem item,
    required ICartProvider cartProvider,
    required IUserProvider userProvider,
  }) async {
    _currentUser ??= await userProvider.fetchUser();

    if (_currentUser is! User) return;

    item.count++;
    await cartProvider.updateCartItem(uuid: _currentUser!.uid, item: item);
  }
}
