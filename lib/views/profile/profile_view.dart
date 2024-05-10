import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/views/home/home_view.dart';
import 'package:mobile_app/views/profile/widgets/profile_form.dart';

class ProfileView extends StatelessWidget {
  static const routeName = '/profile';

  const ProfileView({super.key});

  void _onEditTap() {}

  void _onNavigationTap(int index, BuildContext context) {
    if (index == 1) return;

    Navigator.of(context).pushReplacementNamed(HomeView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            tooltip: 'Edit',
            onPressed: _onEditTap,
            icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) => _onNavigationTap(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: const ProfileForm(),
        ),
      ),
    );
  }
}
