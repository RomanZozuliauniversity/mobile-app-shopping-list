import 'package:get/get.dart';
import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/repositories/cart/interface/i_cart_repo.dart';
import 'package:mobile_app/repositories/cart/src/firebase_cart_repo.dart';
import 'package:mobile_app/repositories/cart/src/local_cart_repo.dart';
import 'package:mobile_app/services/network/interface/i_network_service.dart';

class CartProvider implements ICartProvider {
  final ICartRepo _repo;
  final ICartRepo _localRepo = const LocalCartRepo();

  const CartProvider({
    ICartRepo repo = const FirebaseCartRepo(),
  }) : _repo = repo;

  @override
  Future<void> addCartItem({required String uuid, required Product product}) {
    final networkService = Get.find<INetworkService>(tag: 'network-service');

    if (networkService.isConnected.isTrue) {
      _localRepo.addCartItem(uuid: uuid, product: product);
      return _repo.addCartItem(uuid: uuid, product: product);
    }

    return _localRepo.addCartItem(uuid: uuid, product: product);
  }

  @override
  Future<List<CartItem>> fetchCartItems({required String uuid}) {
    final networkService = Get.find<INetworkService>(tag: 'network-service');

    if (networkService.isConnected.isTrue) {
      return _repo.fetchCartItems(uuid: uuid);
    }

    return _localRepo.fetchCartItems(uuid: uuid);
  }

  @override
  Future<void> removeCartItem({required String uuid, required CartItem item}) {
    final networkService = Get.find<INetworkService>(tag: 'network-service');

    if (networkService.isConnected.isTrue) {
      _localRepo.removeCartItem(uuid: uuid, item: item);
      return _repo.removeCartItem(uuid: uuid, item: item);
    }

    return _localRepo.removeCartItem(uuid: uuid, item: item);
  }

  @override
  Future<void> updateCartItem({required String uuid, required CartItem item}) {
    final networkService = Get.find<INetworkService>(tag: 'network-service');

    if (networkService.isConnected.isTrue) {
      _localRepo.updateCartItem(uuid: uuid, item: item);
      return _repo.updateCartItem(uuid: uuid, item: item);
    }

    return _localRepo.updateCartItem(uuid: uuid, item: item);
  }

  @override
  Future<void> clearCart({required String uuid}) async {
    _localRepo.clearCart(uuid: uuid);

    final networkService = Get.find<INetworkService>(tag: 'network-service');

    if (networkService.isConnected.isTrue) {
      return _repo.clearCart(uuid: uuid);
    }
  }
}
