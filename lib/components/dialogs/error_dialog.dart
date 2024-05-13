import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error', style: TextStyle(fontSize: 16.sp)),
      content: Text(
        message,
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
