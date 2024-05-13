import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoNetworkDialog extends StatelessWidget {
  const NoNetworkDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('No network', style: TextStyle(fontSize: 16.sp)),
      content: Text(
        'You cant perform this action without network connection',
        style: TextStyle(fontSize: 14.sp),
      ),
      actions: [
        TextButton(
          onPressed: Get.back<void>,
          child: Text('Ok', style: TextStyle(fontSize: 14.sp)),
        ),
      ],
    );
  }
}
