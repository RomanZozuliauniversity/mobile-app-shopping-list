import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/managers/session/src/session_manager.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/views/auth/login/login_view.dart';
import 'package:uuid/uuid.dart';

class ProfileController {
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  bool isEditingMode = false;

  User? _currentUser;

  Future<void> init(IUserProvider provider) async {
    User? user;
    final sessionManager = SessionManager();

    if (sessionManager.userHolder.hasUser) {
      user = sessionManager.userHolder.currentUser;
    }

    if (user is! User) {
      Fluttertoast.showToast(msg: 'Failed to fetch user');
      return;
    }

    _currentUser = user;

    firstNameController.text = user.firstName;
    secondNameController.text = user.secondName;
    emailController.text = user.email;
    passwordController.text = user.password;
  }

  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  void onEnterEditingMode() {
    isEditingMode = !isEditingMode;
    rePasswordController.clear();
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

  Future<void> onUpdateUser({
    required GlobalKey<FormState> formKey,
    required IUserProvider provider,
  }) async {
    User createUserRecord() {
      if (_currentUser is User) {
        return _currentUser!.copyWith(
          email: emailController.text.trim(),
          password: passwordController.text,
          firstName: firstNameController.text.trim(),
          secondName: secondNameController.text.trim(),
        );
      }

      return User(
        uid: const Uuid().v4(),
        email: emailController.text.trim(),
        password: passwordController.text,
        firstName: firstNameController.text.trim(),
        secondName: secondNameController.text.trim(),
      );
    }

    if (formKey.currentState?.validate() == false) return;

    provider.updateUser(user: createUserRecord()).then(
      (_) {
        final sessionManager = SessionManager();

        if (_currentUser is User) {
          sessionManager.userHolder.initialize(user: _currentUser!);
        }

        return Fluttertoast.showToast(msg: 'User record updated');
      },
    );
  }

  void onSignOutTap(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?', style: TextStyle(fontSize: 16.sp)),
          content: Text(
            'You are going to sign out, are you sure?',
            style: TextStyle(fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text('Nope', style: TextStyle(fontSize: 14.sp)),
            ),
            TextButton(
              onPressed: () {
                SessionManager().endSession().then(
                      (value) => Navigator.of(context)
                          .pushReplacementNamed(LoginView.routeName),
                    );
              },
              child: Text(
                'Sign out',
                style: TextStyle(color: Colors.red, fontSize: 14.sp),
              ),
            ),
          ],
        );
      },
    );
  }
}
