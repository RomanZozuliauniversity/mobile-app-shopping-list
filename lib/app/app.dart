import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/routes/routes.dart';

class App extends StatelessWidget {
  final Routes routes;

  const App({
    this.routes = const Routes(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        title: 'Shopping List',
        theme: ThemeData(
          primaryColor: Colors.blue,
          useMaterial3: false,
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 18.sp),
            actionsIconTheme: IconThemeData(opticalSize: 24.h),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedIconTheme: IconThemeData(size: 28.sp),
            unselectedIconTheme: IconThemeData(size: 28.sp),
            unselectedLabelStyle: TextStyle(fontSize: 12.sp),
            selectedLabelStyle: TextStyle(fontSize: 12.sp),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: routes.initialRoute,
        routes: routes.routes,
      ),
    );
  }
}
