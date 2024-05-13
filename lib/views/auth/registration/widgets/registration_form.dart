import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mobile_app/components/buttons/custom_elevated_button.dart';
import 'package:mobile_app/components/inputs/custom_text_field.dart';

import 'package:mobile_app/views/auth/registration/controller/registration_controller.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      init: RegistrationController(),
      builder: (controller) {
        return Form(
          key: controller.formKey,
          child: Column(
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
              CustomTextField(
                controller: controller.firstNameController,
                validator: controller.validateName,
                textCapitalization: TextCapitalization.sentences,
                label: 'First name',
                hint: 'Enter your name',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.secondNameController,
                validator: controller.validateName,
                textCapitalization: TextCapitalization.sentences,
                label: 'Second name',
                hint: 'Enter your surname',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              CustomTextField(
                controller: controller.rePasswordController,
                validator: controller.validateRePassword,
                label: 'Repeat password',
                hint: '••••••••',
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                label: 'Create an account',
                onPressed: controller.onRegistrationTap,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: controller.onLoginTap,
                child: Text('Back to login', style: TextStyle(fontSize: 14.sp)),
              ),
            ],
          ),
        );
      },
    );
  }
}
