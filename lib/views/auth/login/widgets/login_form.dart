import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mobile_app/components/buttons/custom_elevated_button.dart';
import 'package:mobile_app/components/inputs/custom_checkbox.dart';
import 'package:mobile_app/components/inputs/custom_text_field.dart';
import 'package:mobile_app/views/auth/login/controller/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Form(
          key: controller.formKey,
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
                controller: controller.emailController,
                validator: controller.validateEmail,
                label: 'Email',
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.passwordController,
                validator: controller.validatePassword,
                label: 'Password',
                hint: '••••••••',
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              Obx(
                () => CustomCheckbox(
                  label: 'Remember me',
                  value: controller.rememberMe.isTrue,
                  onChanged: controller.onRememberMeChanged,
                ),
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                label: 'Login with email',
                onPressed: controller.onLoginTap,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: controller.onRegistrationTap,
                child: Text(
                  'Create new account',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
