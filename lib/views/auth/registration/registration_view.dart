import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/providers/user/src/user_provider.dart';
import 'package:mobile_app/views/auth/registration/controller/registration_controller.dart';

import 'package:mobile_app/views/auth/registration/widgets/registration_form.dart';

class RegistrationView extends StatelessWidget {
  static const routeName = '/registration';

  final IUserProvider _provider;

  const RegistrationView({
    super.key,
    IUserProvider provider = const UserProvider(),
  }) : _provider = provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: RegistrationForm(
            provider: _provider,
            controller: RegistrationController(),
          ),
        ),
      ),
    );
  }
}
