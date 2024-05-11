import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/providers/user/interface/i_user_provider.dart';
import 'package:mobile_app/providers/user/src/user_provider.dart';

import 'package:mobile_app/views/home/home_view.dart';
import 'package:mobile_app/views/profile/controller/profile_controller.dart';
import 'package:mobile_app/views/profile/widgets/profile_form.dart';

class ProfileView extends StatefulWidget {
  static const routeName = '/profile';

  final IUserProvider provider;

  const ProfileView({
    super.key,
    this.provider = const UserProvider(),
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  final controller = ProfileController();

  @override
  void initState() {
    controller.init(widget.provider).then((value) => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

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
            onPressed: () => setState(
              () => controller.onEnterEditingMode(context),
            ),
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
          child: ProfileForm(
            formKey: _formKey,
            provider: widget.provider,
            controller: controller,
          ),
        ),
      ),
    );
  }
}
