import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/managers/session/src/session_manager.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/views/auth/registration/registration_view.dart';
import 'package:mobile_app/views/home/home_view.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool rememberMe = false;

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String? value) {
    if (value is! String || value.trim().isEmpty) {
      return 'Email field is required';
    }

    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

    final regex = RegExp(pattern);
    if (!regex.hasMatch(value)) return 'Enter a valid email address';

    return null;
  }

  String? validatePassword(String? value) {
    if (value is! String || value.trim().isEmpty) {
      return 'Password field is required';
    }
    if (value.length < 8) {
      return 'Password length should be at least 8 symbols';
    }

    return null;
  }

  void onRegistrationTap(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RegistrationView.routeName);
  }

  Future<void> onLoginTap({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required IUserProvider provider,
  }) async {
    if (formKey.currentState?.validate() == false) return;

    provider
        .login(
      email: emailController.text.trim(),
      password: passwordController.text,
      rememberMe: rememberMe,
    )
        .then(
      (authResult) {
        if (authResult.errorMessage is String) {
          return showDialog<void>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error', style: TextStyle(fontSize: 16.sp)),
                content: Text(
                  authResult.errorMessage ?? '',
                  style: TextStyle(fontSize: 14.sp),
                ),
                actions: [
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: Text('Ok', style: TextStyle(fontSize: 14.sp)),
                  ),
                ],
              );
            },
          );
        }

        SessionManager().userHolder.initialize(user: authResult.user!).then(
              (value) => Navigator.of(context)
                  .pushReplacementNamed(HomeView.routeName),
            );
      },
    );
  }
}
