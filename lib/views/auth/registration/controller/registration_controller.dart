import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/components/dialogs/error_dialog.dart';
import 'package:mobile_app/components/dialogs/no_network_dialog.dart';
import 'package:mobile_app/managers/session/interface/i_session_manager.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/services/network/interface/i_network_service.dart';
import 'package:mobile_app/views/auth/login/login_view.dart';
import 'package:mobile_app/views/home/home_view.dart';
import 'package:uuid/uuid.dart';

class RegistrationController extends GetxController {
  final _networkService = Get.find<INetworkService>(tag: 'network-service');
  final _userProvider = Get.find<IUserProvider>(tag: 'user-provider');
  final _sessionManager = Get.find<ISessionManager>(tag: 'session-manager');

  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void onClose() {
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();

    super.onClose();
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

  void onLoginTap() => Get.offNamed<void>(LoginView.routeName);

  Future<void> onRegistrationTap() async {
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

    if (_networkService.isConnected.isFalse) {
      return Get.dialog<void>(const NoNetworkDialog());
    }

    final authResult = await _userProvider.register(user: createUserRecord());

    if (authResult.errorMessage is String) {
      return Get.dialog<void>(ErrorDialog(message: authResult.errorMessage!));
    }

    await _sessionManager.startSession();
    Get.offNamed<void>(HomeView.routeName);
  }
}
