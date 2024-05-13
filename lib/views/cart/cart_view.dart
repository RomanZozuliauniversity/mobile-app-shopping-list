import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mobile_app/components/list/cart_item_tile.dart';
import 'package:mobile_app/models/cart/cart_item.dart';
import 'package:mobile_app/views/cart/controller/cart_controller.dart';

class CartView extends StatelessWidget {
  static const routeName = '/cart';

  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cart'),
            actions: [
              IconButton(
                onPressed: controller.onClearCartTap,
                tooltip: 'Clear',
                icon: const Icon(CupertinoIcons.trash),
              ),
            ],
          ),
          body: FutureBuilder<List<CartItem>>(
            future: controller.cartItems,
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
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 20.w,
                      ),
                      itemCount: data.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) {
                        final item = data.elementAt(index);

                        return CartItemTile(
                          item: item,
                          onDecreaseTap: controller.onDecreaseTap,
                          onIncreaseTap: controller.onIncreaseTap,
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
      },
    );
  }
}
