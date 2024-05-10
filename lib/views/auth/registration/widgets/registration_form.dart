import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/buttons/custom_elevated_button.dart';
import 'package:mobile_app/components/inputs/custom_text_field.dart';

import 'package:mobile_app/views/auth/login/login_view.dart';
import 'package:mobile_app/views/home/home_view.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  }

  void _onRegisterTap(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(HomeView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create new account',
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
        ),
        const SizedBox(height: 16),
        const CustomTextField(
          label: 'Second name',
          hint: 'Enter your surname',
          keyboardType: TextInputType.name,
        ),
        const SizedBox(height: 16),
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
        const SizedBox(height: 16),
        const CustomTextField(
          label: 'Repeat password',
          hint: '••••••••',
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        CustomElevatedButton(
          label: 'Create an account',
          onPressed: () => _onRegisterTap(context),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => _onLoginTap(context),
          child: Text(
            'Back to login',
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
