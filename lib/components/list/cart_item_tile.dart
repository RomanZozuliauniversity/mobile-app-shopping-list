import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:uuid/uuid.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile({super.key});

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
          backgroundImage: NetworkImage(
            'https://picsum.photos/seed/${const Uuid().v4()}/200/300',
          ),
          radius: 20.h,
        ),
        title: Text(
          'Product title',
          style: TextStyle(fontSize: 16.sp),
        ),
        subtitle: Text(
          'Product description',
          style: TextStyle(fontSize: 14.sp),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
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
                '1',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            InkWell(
              onTap: () {},
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
