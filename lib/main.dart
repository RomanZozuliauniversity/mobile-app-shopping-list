import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/app/app.dart';
import 'package:mobile_app/managers/session/src/session_manager.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  await SessionManager().startSession();

  runApp(const App());
}
