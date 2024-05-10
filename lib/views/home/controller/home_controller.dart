import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/views/cart/cart_view.dart';
import 'package:mobile_app/views/product/product_view.dart';

class HomeController {
  User? _currentUser;

  Future<List<Product>> fetchProducts(IProductsProvider provider) {
    return provider.fetchProducts();
  }

  void onCartTap(BuildContext context) {
    Navigator.of(context).pushNamed(CartView.routeName);
  }

  void onProductTap({
    required BuildContext context,
    required Product product,
    required VoidCallback callback,
  }) {
    Navigator.of(context).pushNamed(
      ProductView.routeName,
      arguments: {
        'product': product,
        'callback': callback,
      },
    );
  }

  Future<void> onAddToCartTap({
    required Product product,
    required ICartProvider cartProvider,
    required IUserProvider userProvider,
  }) async {
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
    Navigator.of(context).pushNamed(
      ProductView.routeName,
      arguments: {'callback': callback},
    );
  }
}
