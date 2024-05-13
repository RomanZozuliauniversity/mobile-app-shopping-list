import 'package:custom_light_plugin/custom_light_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobile_app/components/dialogs/no_network_dialog.dart';
import 'package:mobile_app/managers/session/interface/i_session_manager.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:mobile_app/services/network/interface/i_network_service.dart';
import 'package:mobile_app/views/cart/cart_view.dart';
import 'package:mobile_app/views/product/product_view.dart';
import 'package:mobile_app/views/profile/profile_view.dart';

class HomeController extends GetxController {
  final _networkService = Get.find<INetworkService>(tag: 'network-service');
  final _cartProvider = Get.find<ICartProvider>(tag: 'cart-provider');
  final _productsProvider =
      Get.find<IProductsProvider>(tag: 'products-provider');
  final _sessionManager = Get.find<ISessionManager>(tag: 'session-manager');

  Future<List<Product>> get products => _productsProvider.fetchProducts();

  void onToggleLights() => CustomLightPlugin.toggle();

  void onCartTap() {
    if (_networkService.isConnected.isFalse) {
      Get.dialog<void>(const NoNetworkDialog());
      return;
    }

    Get.toNamed<void>(CartView.routeName);
  }

  void onProductTap(Product product) {
    if (_networkService.isConnected.isFalse) {
      Get.dialog<void>(const NoNetworkDialog());
      return;
    }

    Get.toNamed<void>(
      ProductView.routeName,
      arguments: {
        'product': product,
        'callback': update,
      },
    );
  }

  Future<void> onAddToCartTap(Product product) async {
    if (_networkService.isConnected.isFalse) {
      Get.dialog<void>(const NoNetworkDialog());
      return;
    }

    if (_sessionManager.userHolder.currentUser is! User) {
      Fluttertoast.showToast(msg: 'Failed to add cart item');
      return;
    }

    await _cartProvider.addCartItem(
      uuid: _sessionManager.userHolder.currentUser!.uid,
      product: product,
    );
    Fluttertoast.showToast(msg: 'Product added to cart');
  }

  void onAddProductTap() {
    if (_networkService.isConnected.isFalse) {
      Get.dialog<void>(const NoNetworkDialog());
      return;
    }

    Get.toNamed<void>(
      ProductView.routeName,
      arguments: {'callback': update},
    );
  }

  void onNavigationTap(int index) {
    if (index == 0) return;

    Get.offNamed<void>(ProfileView.routeName);
  }
}
