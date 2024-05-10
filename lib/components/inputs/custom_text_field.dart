import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  final String? hint;
  final String? label;

  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;

  final List<TextInputFormatter>? inputFormatters;

  final int? minLines;
  final int? maxLines;

  final bool readOnly;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.controller,
    this.validator,
    this.hint,
    this.label,
    this.keyboardType,
    this.minLines,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.readOnly = false,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      readOnly: readOnly,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      minLines: minLines,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        alignLabelWithHint: true,
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
