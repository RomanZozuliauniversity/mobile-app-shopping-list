import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/buttons/custom_elevated_button.dart';

import 'package:uuid/uuid.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key});

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
        trailing: CustomElevatedButton(
          label: '20\$',
          onPressed: () {},
        ),
      ),
    );
  }
}
