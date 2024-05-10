import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/list/product_tile.dart';

import 'package:mobile_app/views/cart/cart_view.dart';
import 'package:mobile_app/views/profile/profile_view.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home';

  const HomeView({super.key});

  void _onCartTap(BuildContext context) {
    Navigator.of(context).pushNamed(CartView.routeName);
  }

  void _onNavigationTap(int index, BuildContext context) {
    if (index == 0) return;

    Navigator.of(context).pushReplacementNamed(ProfileView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          Badge(
            label: const Text('2'),
            alignment: Alignment.bottomLeft,
            child: IconButton(
              tooltip: 'Cart',
              onPressed: () => _onCartTap(context),
              icon: const Icon(CupertinoIcons.cart),
            ),
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
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return const ProductTile();
        },
      ),
    );
  }
}
