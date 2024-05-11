import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/list/product_tile.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/providers/cart/src/cart_provider.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:mobile_app/providers/products/src/products_provider.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/providers/user/src/user_provider.dart';

import 'package:mobile_app/views/home/controller/home_controller.dart';
import 'package:mobile_app/views/profile/profile_view.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';

  final IProductsProvider productsProvider;
  final ICartProvider cartProvider;
  final IUserProvider userProvider;

  const HomeView({
    this.productsProvider = const ProductsProvider(),
    this.cartProvider = const CartProvider(),
    this.userProvider = const UserProvider(),
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();

  void _onNavigationTap(int index, BuildContext context) {
    if (index == 0) return;

    Navigator.of(context).pushReplacementNamed(ProfileView.routeName);
  }

  @override
  void initState() {
    controller.init();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            tooltip: 'Cart',
            onPressed: () => controller.onCartTap(context),
            icon: const Icon(CupertinoIcons.cart),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _onNavigationTap(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.onAddProductTap(
          context: context,
          callback: () => setState(() {}),
        ),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Product>>(
        future: controller.fetchProducts(widget.productsProvider),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data ?? [];
          if (data.isEmpty) {
            return Center(
              child: Text(
                'No records found',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (_, index) {
              final product = data.elementAt(index);

              return ProductTile(
                product: product,
                onTap: () => controller.onProductTap(
                  context: context,
                  product: product,
                  callback: () => setState(() {}),
                ),
                onAddToCartTap: () => controller.onAddToCartTap(
                  context: context,
                  product: product,
                  userProvider: widget.userProvider,
                  cartProvider: widget.cartProvider,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
