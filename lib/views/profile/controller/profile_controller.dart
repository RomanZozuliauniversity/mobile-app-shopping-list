import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mobile_app/components/dialogs/no_network_dialog.dart';
import 'package:mobile_app/managers/session/interface/i_session_manager.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/services/network/interface/i_network_service.dart';
import 'package:mobile_app/views/auth/login/login_view.dart';
import 'package:mobile_app/views/home/home_view.dart';
import 'package:uuid/uuid.dart';

class ProfileController extends GetxController {
  final _networkService = Get.find<INetworkService>(tag: 'network-service');
  final _sessionManager = Get.find<ISessionManager>(tag: 'session-manager');
  final _userProvider = Get.find<IUserProvider>(tag: 'user-provider');

  final _formKey = GlobalKey<FormState>();
  final _isEditingMode = false.obs;

  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;
  RxBool get isEditingMode => _isEditingMode;

  @override
  void onInit() {
    final user = _sessionManager.userHolder.currentUser;

    if (user is! User) {
      Fluttertoast.showToast(msg: 'Failed to fetch user');
      return;
    }

    firstNameController.text = user.firstName;
    secondNameController.text = user.secondName;
    emailController.text = user.email;
    passwordController.text = user.password;

    super.onInit();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();

    super.onClose();
  }

  void onEnterEditingMode() {
    if (_networkService.isConnected.isFalse) {
      Get.dialog<void>(const NoNetworkDialog());
      return;
    }

    rePasswordController.clear();
    _isEditingMode.value = !_isEditingMode.value;
  }

  String? validateName(String? value) {
    if (value is! String || value.trim().isEmpty) {
      return 'Name field is required';
    }
    if (!value.isAlphabetOnly) {
      return 'May contain only alphabetic characters';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value is! String || value.trim().isEmpty) {
      return 'Email field is required';
    }

    if (!value.isEmail) return 'Enter a valid email address';

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

  Future<void> onUpdateUser() async {
    User createUserRecord() {
      final user = _sessionManager.userHolder.currentUser;

      if (user is User) {
        return user.copyWith(
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

    final user = createUserRecord();

    await _userProvider.updateUser(user: user);
    _sessionManager.userHolder.initialize(user: user);

    Fluttertoast.showToast(msg: 'User record updated');
  }

  void onSignOutTap() {
    Get.dialog<void>(
      AlertDialog(
        title: Text('Are you sure?', style: TextStyle(fontSize: 16.sp)),
        content: Text(
          'You are going to sign out, are you sure?',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: Get.back<void>,
            child: Text('Nope', style: TextStyle(fontSize: 14.sp)),
          ),
          TextButton(
            onPressed: () async {
              await _sessionManager.endSession();
              Get.offNamed<void>(LoginView.routeName);
            },
            child: Text(
              'Sign out',
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  void onNavigationTap(int index) {
    if (index == 1) return;

    Get.offNamed<void>(HomeView.routeName);
  }
}
