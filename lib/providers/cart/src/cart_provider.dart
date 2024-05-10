import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/repositories/cart/interface/i_cart_repo.dart';
import 'package:mobile_app/repositories/cart/src/local_cart_repo.dart';

class CartProvider implements ICartProvider {
  final ICartRepo _repo;

  const CartProvider({
    ICartRepo repo = const LocalCartRepo(),
  }) : _repo = repo;

  @override
  Future<void> addCartItem({required String uuid, required Product product}) =>
      _repo.addCartItem(uuid: uuid, product: product);

  @override
  Future<List<CartItem>> fetchCartItems({required String uuid}) =>
      _repo.fetchCartItems(uuid: uuid);

  @override
  Future<void> removeCartItem({required String uuid, required CartItem item}) =>
      _repo.removeCartItem(uuid: uuid, item: item);

  @override
  Future<void> updateCartItem({required String uuid, required CartItem item}) =>
      _repo.updateCartItem(uuid: uuid, item: item);

  @override
  Future<void> clearCart({required String uuid}) => _repo.clearCart(uuid: uuid);
}
