import 'package:digital_menu/views/mobile_screens/home_screen.dart';
import 'package:digital_menu/views/mobile_screens/menu_screen.dart';
import 'package:digital_menu/views/mobile_screens/profile_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app_constants.dart';
import '../../controller/riverpod_management.dart';
import '../../views/web_screens/cart_screen.dart';
import '../../views/web_screens/web_home.dart';
import '../../views/web_screens/web_menu.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  int _selectedTab = 0;

  final List _pages = kIsWeb
      ? const [
          WebMenu(),
          WebHome(),
          CartScreen(),
        ]
      : const [
          HomeScreen(),
          MenuScreen(),
          ProfileScreen(),
        ];

  _changeTab(int index) {
    if (mounted) {
      setState(() {
        _selectedTab = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final themeProvider = ref.watch(themeRiverpod);
    final cartProvider = ref.watch(cartRiverpod);
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: Visibility(
        visible: screenSize.width < 600 ? true : false,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: themeProvider.darkMode
              ? AppConstant.darkPrimary
              : AppConstant.lightBg,
          currentIndex: _selectedTab,
          onTap: (index) => _changeTab(index),
          selectedItemColor: themeProvider.darkMode
              ? AppConstant.darkAccent
              : AppConstant.lightAccent,
          unselectedItemColor: themeProvider.darkMode
              ? AppConstant.darkBg
              : AppConstant.lightAccent,
          selectedLabelStyle: TextStyle(
              color: themeProvider.darkMode
                  ? AppConstant.darkAccent
                  : AppConstant.lightAccent),
          unselectedLabelStyle: TextStyle(
              color: themeProvider.darkMode
                  ? AppConstant.darkBg
                  : AppConstant.darkPrimary),
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedIconTheme: IconThemeData(
              color: themeProvider.darkMode
                  ? AppConstant.darkAccent
                  : AppConstant.lightAccent),
          unselectedIconTheme: IconThemeData(
            color: themeProvider.darkMode
                ? AppConstant.darkBg
                : AppConstant.darkPrimary,
          ),
          items: kIsWeb
              ? [
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_outlined,
                      size: 24,
                    ),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu_book_outlined,
                      size: 24,
                    ),
                    label: 'About',
                  ),
                  BottomNavigationBarItem(
                    icon: cartProvider.cartItems.isNotEmpty
                        ? Badge(
                            label:
                                Text(cartProvider.cartItems.length.toString()),
                            child: const Icon(Icons.shopping_cart),
                          )
                        : const Icon(
                            Icons.shopping_cart,
                            size: 24,
                          ),
                    label: 'Cart',
                  ),
                ]
              : const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_filled,
                      size: 24,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu_book,
                      size: 24,
                    ),
                    label: 'Menu',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person_2_outlined,
                      size: 24,
                    ),
                    label: 'Profile',
                  ),
                ],
        ),
      ),
    );
  }
}
