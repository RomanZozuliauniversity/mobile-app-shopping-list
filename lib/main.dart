import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/app/app.dart';
import 'package:mobile_app/firebase_options.dart';
import 'package:mobile_app/managers/session/src/session_manager.dart';
import 'package:mobile_app/services/network/network_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ScreenUtil.ensureScreenSize();

  await SessionManager().startSession();

  NetworkService().onConnectivityChanged();

  runApp(const App());
}
