import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/inputs/custom_text_field.dart';

import 'package:mobile_app/views/auth/login/login_view.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  void _onSignOutTap(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account information',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          label: 'First name',
          hint: 'Enter your name',
          keyboardType: TextInputType.name,
          readOnly: true,
        ),
        const SizedBox(height: 16),
        const CustomTextField(
          label: 'Second name',
          hint: 'Enter your surname',
          keyboardType: TextInputType.name,
          readOnly: true,
        ),
        const SizedBox(height: 16),
        const CustomTextField(
          label: 'Email',
          hint: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
          readOnly: true,
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => _onSignOutTap(context),
          child: Text(
            'Sign out',
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
