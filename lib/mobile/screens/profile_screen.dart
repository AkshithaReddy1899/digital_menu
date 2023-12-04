import 'package:digital_menu/mobile/screens/change_language.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/app_constants.dart';
import '../../common/fancy_switch.dart';
import '../../controller/riverpod_management.dart';
import 'contact_support.dart';
import 'past_orders.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  String? language;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeRiverpod);

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: themeProvider.darkMode
                ? AppConstant.darkBg
                : AppConstant.lightBg,
            height: screenSize.height - kToolbarHeight,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: screenSize.width,
                  child: Text(
                    AppLocalizations.of(context)!.logo,
                    style: AppConstant().logoTextStyle(
                      themeProvider.darkMode == true
                          ? AppConstant.lightPrimary
                          : AppConstant.darkPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "logo@gmail.com",
                  style: AppConstant().logoTextStyle(
                    themeProvider.darkMode == true
                        ? AppConstant.lightPrimary
                        : AppConstant.darkPrimary,
                  ),
                ),
                AppConstant().commonText(
                    "+919876543211",
                    16,
                    FontWeight.w500,
                    themeProvider.darkMode
                        ? AppConstant.lightPrimary
                        : AppConstant.lightTextColor,
                    1.5,
                    2),
                SizedBox(
                  width: screenSize.width / 1.5,
                  child: AppConstant().commonText(
                      AppLocalizations.of(context)!.address,
                      16,
                      FontWeight.normal,
                      themeProvider.darkMode
                          ? AppConstant.lightPrimary
                          : AppConstant.lightTextColor,
                      1,
                      1.2),
                ),
                const SizedBox(
                  height: 15,
                ),
                AppConstant().appSubHeader(themeProvider.darkMode,
                    AppLocalizations.of(context)!.past_orders),
                SizedBox(
                  height: screenSize.height / 30,
                ),
                Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: themeProvider.darkMode
                          ? AppConstant.darkBg1
                          : AppConstant.lightPrimary,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PastOrders()),
                      );
                    },
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppConstant().appSideHeader(themeProvider.darkMode,
                            AppLocalizations.of(context)!.view_past_orders),
                        const Icon(Icons.arrow_right)
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                AppConstant().appSubHeader(themeProvider.darkMode,
                    AppLocalizations.of(context)!.app_setting),
                SizedBox(
                  height: screenSize.height / 30,
                ),
                Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      // color: AppConstant.darkBg1,
                      color: themeProvider.darkMode
                          ? AppConstant.darkBg1
                          : AppConstant.lightPrimary,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangeLanguage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppConstant().appSideHeader(
                                themeProvider.darkMode,
                                AppLocalizations.of(context)!.change_lan),
                            const Icon(Icons.arrow_right),
                          ],
                        ),
                      ),
                      Divider(
                        height: 30,
                        color: AppConstant.lightSecondary,
                      ),
                      AppConstant().appSideHeader(themeProvider.darkMode,
                          AppLocalizations.of(context)!.change_them),
                      const SizedBox(
                        height: 10,
                      ),
                      FancySwitch(
                        value: themeProvider.darkMode,
                        height: 20,
                        activeModeBackgroundImage:
                            'assets/images/dark_mode.jpg',
                        inactiveModeBackgroundImage:
                            'assets/images/light_mode.jpg',
                        activeThumbImage: Image.asset('assets/images/sun.png'),
                        inactiveThumbImage:
                            Image.asset('assets/images/moon.png'),
                      ),
                      Divider(
                        height: 30,
                        color: AppConstant.lightSecondary,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactSupport()),
                          );
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppConstant().appSideHeader(themeProvider.darkMode,
                                AppLocalizations.of(context)!.contact),
                            const Icon(Icons.arrow_right)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenSize.height / 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}