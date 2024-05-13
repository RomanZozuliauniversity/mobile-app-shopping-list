import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/services/network/network_service.dart';
import 'package:mobile_app/views/cart/cart_view.dart';
import 'package:mobile_app/views/product/product_view.dart';

class HomeController {
  User? _currentUser;
  bool _hasConnection = true;

  void init() {
    NetworkService()
        .isConnected
        .then((connected) => _hasConnection = connected);
    NetworkService().subscribe(_onNetworkChanged);
  }

  void dispose() {
    NetworkService().unsubscribe(_onNetworkChanged);
  }

  void _onNetworkChanged(bool hasConnection) => _hasConnection = hasConnection;

  Future<List<Product>> fetchProducts(IProductsProvider provider) {
    return provider.fetchProducts();
  }

  void _onNoNetwork(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('No network', style: TextStyle(fontSize: 16.sp)),
          content: Text(
            'You cant perform this action without network connection',
            style: TextStyle(fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text('Ok', style: TextStyle(fontSize: 14.sp)),
            ),
          ],
        );
      },
    );
  }

  void onCartTap(BuildContext context) {
    if (!_hasConnection) return _onNoNetwork(context);

    Navigator.of(context).pushNamed(CartView.routeName);
  }

  void onProductTap({
    required BuildContext context,
    required Product product,
    required VoidCallback callback,
  }) {
    if (!_hasConnection) return _onNoNetwork(context);

    Navigator.of(context).pushNamed(
      ProductView.routeName,
      arguments: {
        'product': product,
        'callback': callback,
      },
    );
  }

  Future<void> onAddToCartTap({
    required BuildContext context,
    required Product product,
    required ICartProvider cartProvider,
    required IUserProvider userProvider,
  }) async {
    if (!_hasConnection) return _onNoNetwork(context);

    _currentUser ??= await userProvider.fetchUser();

    if (_currentUser is! User) {
      Fluttertoast.showToast(msg: 'Failed to add cart item');
      return;
    }

    cartProvider
        .addCartItem(uuid: _currentUser!.uid, product: product)
        .then((value) => Fluttertoast.showToast(msg: 'Product added to cart'));
  }

  void onAddProductTap({
    required BuildContext context,
    required VoidCallback callback,
  }) {
    if (!_hasConnection) return _onNoNetwork(context);

    Navigator.of(context).pushNamed(
      ProductView.routeName,
      arguments: {'callback': callback},
    );
  }
}
