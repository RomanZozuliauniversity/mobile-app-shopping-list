import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String? hint;
  final String? label;

  final TextInputType? keyboardType;

  final bool readOnly;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.keyboardType,
    this.readOnly = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      obscureText: obscureText,
      style: TextStyle(
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.sp,
        ),
        labelStyle: TextStyle(
          fontSize: 14.sp,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
