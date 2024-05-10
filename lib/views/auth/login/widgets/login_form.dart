import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/buttons/custom_elevated_button.dart';
import 'package:mobile_app/components/inputs/custom_checkbox.dart';
import 'package:mobile_app/components/inputs/custom_text_field.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/views/auth/login/controller/login_controller.dart';

class LoginForm extends StatefulWidget {
  final IUserProvider provider;
  final LoginController controller;

  const LoginForm({
    required this.provider,
    required this.controller,
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    widget.controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
          CustomTextField(
            controller: widget.controller.emailController,
            validator: widget.controller.validateEmail,
            label: 'Email',
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: widget.controller.passwordController,
            validator: widget.controller.validatePassword,
            label: 'Password',
            hint: '••••••••',
            keyboardType: TextInputType.text,
            obscureText: true,
          ),
          CustomCheckbox(
            label: 'Remember me',
            value: widget.controller.rememberMe,
            onChanged: (value) {
              setState(() {
                widget.controller.rememberMe = value ?? false;
              });
            },
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            label: 'Login with email',
            onPressed: () => widget.controller.onLoginTap(
              context: context,
              provider: widget.provider,
              formKey: _formKey,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => widget.controller.onRegistrationTap(context),
            child: Text(
              'Create new account',
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
