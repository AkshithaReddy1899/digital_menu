import 'package:digital_menu/common/app_constants.dart';
import 'package:digital_menu/controller/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/fancy_switch.dart';
import '../../common/components/bottom_nav_bar.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeRiverpod);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            themeProvider.darkMode ? AppConstant.darkBg : AppConstant.lightBg,
        leadingWidth: 140,
        actions: [
          TextButton(
            onPressed: null,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeProvider.darkMode ? Colors.white : Colors.black,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: FancySwitch(
                value: themeProvider.darkMode,
                height: 20,
                activeModeBackgroundImage: 'assets/images/dark_mode.jpg',
                inactiveModeBackgroundImage: 'assets/images/light_mode.jpg',
                activeThumbImage: Image.asset('assets/images/sun.png'),
                inactiveThumbImage: Image.asset('assets/images/moon.png'),
              ),
            ),
          ),
          const SizedBox(
            width: 25,
          )
        ],
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: themeProvider.darkMode == true
            ? AppConstant.darkBg
            : AppConstant.lightBg,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'logo',
                style: AppConstant().logoTextStyle(
                  themeProvider.darkMode == true
                      ? AppConstant.darkAccent
                      : AppConstant.lightAccent,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              AppConstant().commonTextField(nameController, "Enter Name",
                  TextInputType.emailAddress, themeProvider.darkMode),
              const SizedBox(
                height: 30,
              ),
              AppConstant().commonTextField(nameController, "Enter Password",
                  TextInputType.emailAddress, themeProvider.darkMode),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: screenSize.width,
                child: AppConstant().elevatedButton(themeProvider.darkMode, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavBar()),
                  );
                }, 'Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
