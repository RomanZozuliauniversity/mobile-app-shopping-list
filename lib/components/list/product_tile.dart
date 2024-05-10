import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/buttons/custom_elevated_button.dart';
import 'package:mobile_app/models/product/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  final VoidCallback onTap;
  final VoidCallback onAddToCartTap;

  const ProductTile({
    required this.product,
    required this.onTap,
    required this.onAddToCartTap,
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
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(product.imageUrl),
          radius: 20.h,
        ),
        title: Text(
          product.title,
          style: TextStyle(fontSize: 16.sp),
        ),
        subtitle: Text(
          product.description,
          style: TextStyle(fontSize: 14.sp),
        ),
        trailing: CustomElevatedButton(
          label: '${product.price.toStringAsFixed(1)}\$',
          onPressed: onAddToCartTap,
        ),
      ),
    );
  }
}
