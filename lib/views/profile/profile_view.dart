import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_app/views/profile/controller/profile_controller.dart';
import 'package:mobile_app/views/profile/widgets/profile_form.dart';

class ProfileView extends StatelessWidget {
  static const routeName = '/profile';

  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                tooltip: 'Edit',
                onPressed: controller.onEnterEditingMode,
                icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1,
            onTap: controller.onNavigationTap,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: ProfileForm(controller: controller),
            ),
          ),
        );
      },
    );
  }
}
