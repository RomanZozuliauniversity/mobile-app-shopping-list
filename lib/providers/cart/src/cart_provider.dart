import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/repositories/cart/interface/i_cart_repo.dart';
import 'package:mobile_app/repositories/cart/src/firebase_cart_repo.dart';
import 'package:mobile_app/repositories/cart/src/local_cart_repo.dart';
import 'package:mobile_app/services/network/network_service.dart';

class CartProvider implements ICartProvider {
  final ICartRepo _repo;
  final ICartRepo _localRepo = const LocalCartRepo();

  const CartProvider({
    ICartRepo repo = const FirebaseCartRepo(),
  }) : _repo = repo;

  @override
  Future<void> addCartItem({
    required String uuid,
    required Product product,
  }) async {
    if (await NetworkService().isConnected) {
      _localRepo.addCartItem(uuid: uuid, product: product);
      return _repo.addCartItem(uuid: uuid, product: product);
    }

    return _localRepo.addCartItem(uuid: uuid, product: product);
  }

  @override
  Future<List<CartItem>> fetchCartItems({required String uuid}) async {
    if (await NetworkService().isConnected) {
      return _repo.fetchCartItems(uuid: uuid);
    }

    return _localRepo.fetchCartItems(uuid: uuid);
  }

  @override
  Future<void> removeCartItem({
    required String uuid,
    required CartItem item,
  }) async {
    if (await NetworkService().isConnected) {
      _localRepo.removeCartItem(uuid: uuid, item: item);
      return _repo.removeCartItem(uuid: uuid, item: item);
    }

    return _localRepo.removeCartItem(uuid: uuid, item: item);
  }

  @override
  Future<void> updateCartItem({
    required String uuid,
    required CartItem item,
  }) async {
    if (await NetworkService().isConnected) {
      _localRepo.updateCartItem(uuid: uuid, item: item);
      return _repo.updateCartItem(uuid: uuid, item: item);
    }

    return _localRepo.updateCartItem(uuid: uuid, item: item);
  }

  @override
  Future<void> clearCart({required String uuid}) async {
    _localRepo.clearCart(uuid: uuid);

    if (await NetworkService().isConnected) {
      return _repo.clearCart(uuid: uuid);
    }
  }
}
