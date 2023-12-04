import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../views/web_screens/cart_screen.dart';
import '../views/web_screens/web_home.dart';
import '../views/web_screens/web_menu.dart';
import 'app_constants.dart';
import 'fancy_switch.dart';

class WebConstants {
  webButton(label, onPressed, isDark) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  isDark ? AppConstant.darkAccent : AppConstant.lightAccent)),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: isDark ? AppConstant.lightAccent : AppConstant.darkAccent,
            ),
          )),
    );
  }

  BottomNavigationBarItem navItem(Icon icon, String label) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }

  constSpacing(height) {
    return (SizedBox(
      height: height,
    ));
  }

  tabBarItem(controller, label, index, count, darktheme) {
    return Tab(
      height: 70,
      child: Column(
        children: [
          Text(label),
          constSpacing(7),
          Container(
            width: 37,
            height: 21,
            padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
            decoration: BoxDecoration(
                color: controller!.index == index
                    ? darktheme == false
                        ? const Color(0xffffe0b2)
                        : const Color(0xffFF9800)
                    : darktheme == false
                        ? const Color(0xfffff3e0)
                        : const Color.fromRGBO(246, 225, 192, 0.33),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "$count",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    height: 0,
                    color: Color(0xff212121)),
              ),
            ),
          ),
          WebConstants().constSpacing(6),
        ],
      ),
    );
  }

  webActionText(onPressed, label, isDark) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
            color: isDark ? AppConstant.darkAccent : AppConstant.lightAccent),
      ),
    );
  }

  webAppBar(context, screenSize, isDark, cartProvider) {
    return screenSize.width > 500
        ? AppBar(
            elevation: 0,
            backgroundColor:
                isDark ? AppConstant.darkBg1 : AppConstant.lightPrimary,
            leading: Container(
              padding: EdgeInsets.only(left: screenSize.width / 20),
              child: Center(
                child: Text(
                  'Ruchulu',
                  style: AppConstant().logoTextStyle(
                    isDark ? AppConstant.lightPrimary : AppConstant.lightAccent,
                  ),
                ),
              ),
            ),
            leadingWidth: 210,
            actions: [
              webActionText(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WebMenu()),
                  );
                },
                "Menu",
                isDark,
              ),
              webActionText(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WebHome()),
                  );
                },
                "About",
                isDark,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                child: cartProvider.cartItems.isNotEmpty
                    ? Badge(
                        label: Text(cartProvider.cartItems.length.toString()),
                        child: Icon(
                          Icons.shopping_cart,
                          color: isDark
                              ? AppConstant.darkAccent
                              : AppConstant.lightAccent,
                        ),
                      )
                    : Icon(
                        Icons.shopping_cart,
                        color: isDark
                            ? AppConstant.darkAccent
                            : AppConstant.lightAccent,
                        size: 24,
                      ),
              ),
              TextButton(
                onPressed: () {},
                child: FancySwitch(
                  value: isDark,
                  height: 20,
                  activeModeBackgroundImage: 'assets/images/dark_mode.jpg',
                  inactiveModeBackgroundImage: 'assets/images/light_mode.jpg',
                  activeThumbImage: Image.asset('assets/images/sun.png'),
                  inactiveThumbImage: Image.asset('assets/images/moon.png'),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: screenSize.width / 20),
              )
            ],
          )
        : AppBar(
            elevation: 0,
            backgroundColor:
                isDark ? AppConstant.darkBg : AppConstant.lightPrimary,
            leading: Center(
              child: Text(
                'RUCHULU.',
                style: AppConstant().logoTextStyle(
                  isDark ? AppConstant.lightPrimary : AppConstant.lightAccent,
                ),
              ),
            ),
            leadingWidth: 140,
            actions: [
              TextButton(
                onPressed: () {},
                child: FancySwitch(
                  value: isDark,
                  height: 20,
                  activeModeBackgroundImage: 'assets/images/dark_mode.jpg',
                  inactiveModeBackgroundImage: 'assets/images/light_mode.jpg',
                  activeThumbImage: Image.asset('assets/images/sun.png'),
                  inactiveThumbImage: Image.asset('assets/images/moon.png'),
                ),
              ),
              const SizedBox(
                width: 25,
              )
            ],
          );
  }

  homeHeading(label, isDark) {
    return Text(
      label,
      textAlign: TextAlign.left,
      style: GoogleFonts.playfairDisplay(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          height: 1,
          color: isDark ? AppConstant.lightBg : AppConstant.lightAccent),
    );
  }

  aboutSubHeading(label, isDark) {
    return Text(
      label,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: isDark ? AppConstant.lightBg1 : AppConstant.darkBg1,
        fontSize: 16,
      ),
    );
  }
}
