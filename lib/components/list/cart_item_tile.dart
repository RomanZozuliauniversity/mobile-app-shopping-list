import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/models/cart/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;

  final ValueChanged<CartItem> onIncreaseTap;
  final ValueChanged<CartItem> onDecreaseTap;

  const CartItemTile({
    required this.item,
    required this.onIncreaseTap,
    required this.onDecreaseTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade400),
        ),
      ),
      child: ListTile(
        style: ListTileStyle.list,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.product.imageUrl),
          radius: 20.h,
        ),
        title: Text(
          item.product.title,
          style: TextStyle(fontSize: 16.sp),
        ),
        subtitle: Text(
          item.product.description,
          style: TextStyle(fontSize: 14.sp),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => onDecreaseTap(item),
              borderRadius: BorderRadius.circular(100.r),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Icon(
                  CupertinoIcons.minus,
                  size: 16.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                item.count.toString(),
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            InkWell(
              onTap: () => onIncreaseTap(item),
              borderRadius: BorderRadius.circular(100.r),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Icon(
                  CupertinoIcons.plus,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
