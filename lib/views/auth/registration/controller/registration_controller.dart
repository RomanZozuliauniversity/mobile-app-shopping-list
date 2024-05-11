import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/managers/session/src/session_manager.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/views/auth/login/login_view.dart';
import 'package:mobile_app/views/home/home_view.dart';
import 'package:uuid/uuid.dart';

class RegistrationController {
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  String? validateName(String? value) {
    if (value is! String || value.trim().isEmpty) {
      return 'Name field is required';
    }
    if (!RegExp(r'^[A-Za-z]+$').hasMatch(value)) {
      return 'May contain only alphabetic characters';
    }

    return null;
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

  String? validateRePassword(String? value) {
    if (value is! String || value.trim().isEmpty) {
      return 'Password field is required';
    }
    if (value != passwordController.text) {
      return 'Passwords should match';
    }

    return null;
  }

  void onLoginTap(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  }

  Future<void> onRegistrationTap({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required IUserProvider provider,
  }) async {
    User createUserRecord() {
      return User(
        uid: const Uuid().v4(),
        email: emailController.text.trim(),
        password: passwordController.text,
        firstName: firstNameController.text.trim(),
        secondName: secondNameController.text.trim(),
      );
    }

    if (formKey.currentState?.validate() == false) return;

    provider.register(user: createUserRecord()).then(
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

        SessionManager().startSession().then(
              (value) => Navigator.of(context)
                  .pushReplacementNamed(HomeView.routeName),
            );
      },
    );
  }
}
