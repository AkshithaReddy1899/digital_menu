// import 'dart:ui';

// import 'package:digital_menu/web/screens/web_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'common.dart/app_constants.dart';
// import 'common.dart/fancy_switch.dart';
// import 'common.dart/providers/theme_provider.dart';
// import 'web/screens/cart_screen.dart';
// import 'web/screens/web_home.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ThemeProvider(),
//       child: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   int _selectedIndex = 0;

//   bool isSelected = true;

//   List<Widget> pages = <Widget>[
//     const WebMenu(),
//     const WebHome(),
//     const CartScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ThemeProvider>(context);
//     Size screenSize = MediaQuery.of(context).size;
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: false),
//       debugShowCheckedModeBanner: false,
//       scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
//       home: Scaffold(
//         // backgroundColor: AppConstant.lightPrimary,
//         backgroundColor:
//             provider.darkMode ? AppConstant.darkSecondary : AppConstant.lightPrimary,
//         appBar: screenSize.width > 500
//             ? AppBar(
//                 elevation: 0,
//                 backgroundColor: provider.darkMode
//                     ? AppConstant.darkSecondary
//                     : AppConstant.lightPrimary,
//                 leading: Container(
//                   padding: EdgeInsets.only(left: screenSize.width / 20),
//                   child: Center(
//                     child: Text(
//                       'logo',
//                       style: AppConstant().logoTextStyle(
//                         provider.darkMode
//                             ? AppConstant.lightPrimary
//                             : AppConstant.darkSecondary,
//                       ),
//                     ),
//                   ),
//                 ),
//                 leadingWidth: 210,
//                 actions: [
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text('Home'),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text('Menu'),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text('Cart'),
//                   ),
//                   FancySwitch(
//                     value: provider.darkMode,
//                     // onChanged: provider.toggleDarkMode,
//                     height: 20,
//                     activeModeBackgroundImage: 'assets/images/dark_mode.jpg',
//                     inactiveModeBackgroundImage: 'assets/images/light_mode.jpg',
//                     activeThumbImage: Image.asset('assets/images/sun.png'),
//                     inactiveThumbImage: Image.asset('assets/images/moon.png'),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(right: screenSize.width / 20),
//                   )
//                 ],
//               )
//             : AppBar(
//                 elevation: 0,
//                 backgroundColor: provider.darkMode
//                     ? AppConstant.darkSecondary
//                     : AppConstant.lightPrimary,
//                 // backgroundColor: Colors.amber,
//                 leading: Center(
//                   child: Text(
//                     'Logo.',
//                     style: AppConstant().logoTextStyle(
//                       provider.darkMode
//                           ? AppConstant.lightPrimary
//                           : AppConstant.darkSecondary,
//                     ),
//                   ),
//                 ),
//                 leadingWidth: 140,
//                 actions: [
//                   TextButton(
//                     onPressed: () {},
//                     child: FancySwitch(
//                       value: provider.darkMode,
//                       // onChanged: provider.toggleDarkMode,
//                       height: 20,
//                       activeModeBackgroundImage: 'assets/images/dark_mode.jpg',
//                       inactiveModeBackgroundImage:
//                           'assets/images/light_mode.jpg',
//                       activeThumbImage: Image.asset('assets/images/sun.png'),
//                       inactiveThumbImage: Image.asset('assets/images/moon.png'),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 25,
//                   )
//                 ],
//               ),
//         bottomNavigationBar: AnimatedContainer(
//           duration: const Duration(milliseconds: 50),
//           height: screenSize.width < 500 ? 60.0 : 0.0,
//           child: screenSize.width < 500
//               ? AnimatedContainer(
//                   duration: const Duration(milliseconds: 50),
//                   height: screenSize.width < 500 ? 60.0 : 0.0,
//                   child: BottomNavigationBar(
//                     type: BottomNavigationBarType.fixed,
//                     backgroundColor: AppConstant.darkSecondary,
//                     currentIndex: _selectedIndex,
//                     onTap: (index) {
//                       setState(() {
//                         _selectedIndex = index;
//                       });
//                     },
//                     items: const [
//                       BottomNavigationBarItem(
//                         icon: Icon(
//                           Icons.home_outlined,
//                           size: 24,
//                         ),
//                         label: 'Home',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(
//                           Icons.menu_book_outlined,
//                           size: 24,
//                         ),
//                         label: 'Menu',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(
//                           Icons.menu_book_outlined,
//                           size: 24,
//                         ),
//                         label: 'Cart',
//                       ),
//                     ],
//                     selectedFontSize: 10,
//                     unselectedFontSize: 10,
//                     selectedIconTheme: const IconThemeData(color: Colors.white),
//                     unselectedIconTheme: IconThemeData(
//                       color: AppConstant.lightSecondary,
//                     ),
//                     selectedItemColor: Colors.white,
//                     // isDarkTheme ? AppConstant.darkPrimary : AppConstant.lightPrimary,
//                     unselectedItemColor: AppConstant.lightSecondary,
//                     selectedLabelStyle: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.white),
//                     showUnselectedLabels: true,
//                   ))
//               : Container(
//                   color: Colors.transparent,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//         ),
//         body: SingleChildScrollView(
//           child: pages.elementAt(_selectedIndex),
//         ),
//       ),
//     );
//   }
// }

// class NoThumbScrollBehavior extends ScrollBehavior {
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//         PointerDeviceKind.stylus,
//         PointerDeviceKind.trackpad,
//       };
// }
