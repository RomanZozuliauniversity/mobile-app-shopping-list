import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/providers/user/src/user_provider.dart';
import 'package:mobile_app/views/auth/login/controller/login_controller.dart';

import 'package:mobile_app/views/auth/login/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  static const routeName = '/login';

  final IUserProvider _provider;

  const LoginView({
    super.key,
    IUserProvider provider = const UserProvider(),
  }) : _provider = provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome back'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: LoginForm(provider: _provider, controller: LoginController()),
        ),
      ),
    );
  }
}
