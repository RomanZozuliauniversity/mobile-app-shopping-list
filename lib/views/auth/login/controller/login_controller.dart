import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/components/dialogs/error_dialog.dart';
import 'package:mobile_app/components/dialogs/no_network_dialog.dart';
import 'package:mobile_app/managers/session/interface/i_session_manager.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/services/network/interface/i_network_service.dart';
import 'package:mobile_app/views/auth/registration/registration_view.dart';
import 'package:mobile_app/views/home/home_view.dart';

class LoginController extends GetxController {
  final _networkService = Get.find<INetworkService>(tag: 'network-service');
  final _userProvider = Get.find<IUserProvider>(tag: 'user-provider');
  final _sessionManager = Get.find<ISessionManager>(tag: 'session-manager');

  final _formKey = GlobalKey<FormState>();
  final _rememberMe = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  GlobalKey<FormState> get formKey => _formKey;
  RxBool get rememberMe => _rememberMe;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
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

  void onRememberMeChanged(bool? value) => _rememberMe.value = value ?? false;

  void onRegistrationTap() => Get.offNamed<void>(RegistrationView.routeName);

  Future<void> onLoginTap() async {
    if (formKey.currentState?.validate() == false) return;

    if (_networkService.isConnected.isFalse) {
      return Get.dialog(const NoNetworkDialog());
    }

    final authResult = await _userProvider.login(
      email: emailController.text.trim(),
      password: passwordController.text,
      rememberMe: rememberMe.isTrue,
    );

    if (authResult.errorMessage is String) {
      return Get.dialog<void>(
        ErrorDialog(message: authResult.errorMessage!),
      );
    }

    await _sessionManager.userHolder.initialize(user: authResult.user!);

    Get.offNamed<void>(HomeView.routeName);
  }
}
