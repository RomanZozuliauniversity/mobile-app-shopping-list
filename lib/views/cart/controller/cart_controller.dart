import 'package:get/get.dart';
import 'package:mobile_app/managers/session/interface/i_session_manager.dart';
import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';

class CartController extends GetxController {
  final _cartProvider = Get.find<ICartProvider>(tag: 'cart-provider');
  final _sessionManager = Get.find<ISessionManager>(tag: 'session-manager');

  Future<void> onClearCartTap() async {
    final user = _sessionManager.userHolder.currentUser;
    if (user is! User) return;

    await _cartProvider.clearCart(uuid: user.uid);
    update();
  }

  Future<List<CartItem>> get cartItems async {
    final user = _sessionManager.userHolder.currentUser;
    if (user is! User) return [];

    return _cartProvider.fetchCartItems(uuid: user.uid);
  }

  Future<void> onDecreaseTap(CartItem item) async {
    final user = _sessionManager.userHolder.currentUser;
    if (user is! User) return;

    if (item.count - 1 > 0) {
      item.count--;
      await _cartProvider.updateCartItem(uuid: user.uid, item: item);
    } else {
      await _cartProvider.removeCartItem(uuid: user.uid, item: item);
    }

    update();
  }

  Future<void> onIncreaseTap(CartItem item) async {
    final user = _sessionManager.userHolder.currentUser;
    if (user is! User) return;

    item.count++;
    await _cartProvider.updateCartItem(uuid: user.uid, item: item);
    update();
  }
}
