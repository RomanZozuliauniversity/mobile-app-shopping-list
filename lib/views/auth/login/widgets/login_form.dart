import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/buttons/custom_elevated_button.dart';
import 'package:mobile_app/components/inputs/custom_checkbox.dart';
import 'package:mobile_app/components/inputs/custom_text_field.dart';

import 'package:mobile_app/views/auth/registration/registration_view.dart';
import 'package:mobile_app/views/home/home_view.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  void _onRememberMeChanged(bool? value) {}

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(HomeView.routeName);
  }

  void _onRegisterTap(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RegistrationView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
        const SizedBox(height: 20),
        const CustomTextField(
          label: 'Email',
          hint: 'Enter your email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        const CustomTextField(
          label: 'Password',
          hint: '••••••••',
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
        CustomCheckbox(
          label: 'Remember me',
          value: false,
          onChanged: _onRememberMeChanged,
        ),
        const SizedBox(height: 20),
        CustomElevatedButton(
          label: 'Login with email',
          onPressed: () => _onLoginTap(context),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => _onRegisterTap(context),
          child: Text(
            'Create new account',
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
