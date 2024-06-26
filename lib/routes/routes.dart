import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_app/managers/session/interface/i_session_manager.dart';

import 'package:mobile_app/views/auth/login/login_view.dart';
import 'package:mobile_app/views/auth/registration/registration_view.dart';
import 'package:mobile_app/views/cart/cart_view.dart';
import 'package:mobile_app/views/home/home_view.dart';
import 'package:mobile_app/views/product/product_view.dart';
import 'package:mobile_app/views/profile/profile_view.dart';

class Routes {
  const Routes();

  String get initialRoute {
    final sessionManager = Get.find<ISessionManager>(tag: 'session-manager');

    if (sessionManager.isSessionStarted) {
      Fluttertoast.showToast(
        msg: 'Welcome back ${sessionManager.userHolder.currentUser?.firstName}',
      );
      return HomeView.routeName;
    }

    return LoginView.routeName;
  }

  Map<String, WidgetBuilder> get routes {
    return {
      LoginView.routeName: (_) => const LoginView(),
      RegistrationView.routeName: (_) => const RegistrationView(),
      HomeView.routeName: (_) => const HomeView(),
      ProfileView.routeName: (_) => const ProfileView(),
      CartView.routeName: (_) => const CartView(),
      ProductView.routeName: (_) => const ProductView(),
    };
  }
}
