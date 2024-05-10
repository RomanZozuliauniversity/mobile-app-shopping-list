import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/components/buttons/custom_elevated_button.dart';
import 'package:mobile_app/components/inputs/custom_text_field.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';

import 'package:mobile_app/views/auth/registration/controller/registration_controller.dart';

class RegistrationForm extends StatefulWidget {
  final RegistrationController controller;
  final IUserProvider provider;

  const RegistrationForm({
    required this.controller,
    required this.provider,
    super.key,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
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
            'Create new account',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
            ),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: widget.controller.firstNameController,
            validator: widget.controller.validateName,
            textCapitalization: TextCapitalization.sentences,
            label: 'First name',
            hint: 'Enter your name',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: widget.controller.secondNameController,
            validator: widget.controller.validateName,
            textCapitalization: TextCapitalization.sentences,
            label: 'Second name',
            hint: 'Enter your surname',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          CustomTextField(
            controller: widget.controller.rePasswordController,
            validator: widget.controller.validateRePassword,
            label: 'Repeat password',
            hint: '••••••••',
            keyboardType: TextInputType.text,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          CustomElevatedButton(
            label: 'Create an account',
            onPressed: () => widget.controller.onRegistrationTap(
              formKey: _formKey,
              context: context,
              provider: widget.provider,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => widget.controller.onLoginTap(context),
            child: Text('Back to login', style: TextStyle(fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }
}
