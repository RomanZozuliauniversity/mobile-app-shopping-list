import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mobile_app/components/inputs/custom_text_field.dart';

import 'package:mobile_app/views/profile/controller/profile_controller.dart';

class ProfileForm extends StatelessWidget {
  final ProfileController controller;

  const ProfileForm({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${controller.isEditingMode.isTrue ? 'Editing ' : ''}'
              'Account information',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.sp,
              ),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: controller.firstNameController,
              validator: controller.validateName,
              label: 'First name',
              hint: 'Enter your name',
              keyboardType: TextInputType.name,
              readOnly: controller.isEditingMode.isFalse,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.secondNameController,
              validator: controller.validateName,
              label: 'Second name',
              hint: 'Enter your surname',
              keyboardType: TextInputType.name,
              readOnly: controller.isEditingMode.isFalse,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: controller.emailController,
              validator: controller.validateEmail,
              label: 'Email',
              hint: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              readOnly: controller.isEditingMode.isFalse,
            ),
            Visibility(
              visible: controller.isEditingMode.isTrue,
              child: Column(
                children: [
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
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: controller.isEditingMode.isTrue
                  ? controller.onUpdateUser
                  : controller.onSignOutTap,
              child: Text(
                controller.isEditingMode.isTrue ? 'Update profile' : 'Sign out',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
