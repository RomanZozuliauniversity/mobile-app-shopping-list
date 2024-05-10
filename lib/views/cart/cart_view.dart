import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/list/cart_item_tile.dart';
import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/providers/cart/src/cart_provider.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/providers/user/src/user_provider.dart';
import 'package:mobile_app/views/cart/controller/cart_controller.dart';

class CartView extends StatefulWidget {
  static const routeName = '/cart';

  final ICartProvider cartProvider;
  final IUserProvider userProvider;

  const CartView({
    super.key,
    this.cartProvider = const CartProvider(),
    this.userProvider = const UserProvider(),
  });

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final controller = CartController();

  void _onClearCartTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            onPressed: () => controller
                .onClearCartTap(
                  cartProvider: widget.cartProvider,
                  userProvider: widget.userProvider,
                )
                .then((value) => setState(() {})),
            tooltip: 'Clear',
            icon: const Icon(CupertinoIcons.trash),
          ),
        ],
      ),
      body: FutureBuilder<List<CartItem>>(
        future: controller.fetchCartItems(
          cartProvider: widget.cartProvider,
          userProvider: widget.userProvider,
        ),
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

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  itemCount: data.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    final item = data.elementAt(index);

                    return CartItemTile(
                      item: item,
                      onDecreaseTap: () => controller
                          .onDecreaseTap(
                            item: item,
                            cartProvider: widget.cartProvider,
                            userProvider: widget.userProvider,
                          )
                          .then((value) => setState(() {})),
                      onIncreaseTap: () => controller
                          .onIncreaseTap(
                            item: item,
                            cartProvider: widget.cartProvider,
                            userProvider: widget.userProvider,
                          )
                          .then((value) => setState(() {})),
                    );
                  },
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                child: SizedBox(
                  height: 90.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total price:',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          '${data.fold(0, (p, e) => p + e.price.floor())}\$',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
