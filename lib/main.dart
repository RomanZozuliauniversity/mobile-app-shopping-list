import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:mobile_app/app/app.dart';
import 'package:mobile_app/firebase_options.dart';
import 'package:mobile_app/managers/session/interface/i_session_manager.dart';
import 'package:mobile_app/managers/session/src/session_manager.dart';
import 'package:mobile_app/managers/session/src/user_holder.dart';
import 'package:mobile_app/providers/cart/interface/i_cart_provider.dart';
import 'package:mobile_app/providers/cart/src/cart_provider.dart';
import 'package:mobile_app/providers/products/interface/i_products_provider.dart';
import 'package:mobile_app/providers/products/src/products_provider.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/providers/user/src/user_provider.dart';
import 'package:mobile_app/services/network/interface/i_network_service.dart';
import 'package:mobile_app/services/network/src/network_service.dart';

Future<void> _initializeServices() async {
  final networkService = Get.put<INetworkService>(
    NetworkService(),
    tag: 'network-service',
  );

  await networkService.startListener();

  final userProvider = Get.put<IUserProvider>(
    const UserProvider(),
    tag: 'user-provider',
  );

  Get.put<ICartProvider>(const CartProvider(), tag: 'cart-provider');
  Get.put<IProductsProvider>(
    const ProductsProvider(),
    tag: 'products-provider',
  );

  final sessionManager = Get.put<ISessionManager>(
    SessionManager(userHolder: UserHolder(), provider: userProvider),
    tag: 'session-manager',
  );

  await sessionManager.startSession();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _initializeServices();

  runApp(const App());
}
