import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mobile_app/components/list/product_tile.dart';
import 'package:mobile_app/models/product/product.dart';
import 'package:mobile_app/views/home/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  static const routeName = '/home';

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              tooltip: 'Cart',
              onPressed: controller.onCartTap,
              icon: const Icon(CupertinoIcons.cart),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: controller.onNavigationTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.onAddProductTap,
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Product>>(
          future: controller.products,
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
                  onTap: controller.onProductTap,
                  onAddToCartTap: controller.onAddToCartTap,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
