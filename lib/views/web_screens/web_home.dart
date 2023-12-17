import 'package:digital_menu/common/app_constant_web.dart';
import 'package:digital_menu/controller/riverpod_management.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../common/app_constants.dart';
import 'web_menu.dart';

class WebHome extends ConsumerStatefulWidget {
  const WebHome({super.key});

  @override
  ConsumerState<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends ConsumerState<WebHome>
    with TickerProviderStateMixin {
  List<int> list = [1, 2, 3, 4, 5];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeRiverpod);
    final cartProvider = ref.watch(cartRiverpod);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: WebConstants()
          .webAppBar(context, screenSize, themeProvider.darkMode, cartProvider),
      body: ScreenTypeLayout.builder(
        mobile: (BuildContext context) => mobileScreen(),
        desktop: (BuildContext context) => desktopScreen(),
      ),
    );
  }

  Widget mobileScreen() {
    Size screenSize = MediaQuery.of(context).size;
    final themeProvider = ref.watch(themeRiverpod);
    return SingleChildScrollView(
      child: Container(
        color:
            themeProvider.darkMode ? AppConstant.darkBg : AppConstant.lightBg,
        child: Column(
          children: [
            Visibility(
              visible: screenSize.width < 600 ? true : false,
              child: SizedBox(
                height: screenSize.height / 20,
              ),
            ),
            // HOME PART 1
            Container(
              padding: EdgeInsets.only(
                  left: screenSize.width / 10, right: screenSize.width / 10),
              child: ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                    sm: 6,
                    xs: 12,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: screenSize.width > 1240
                              ? screenSize.width / 10
                              : 0),
                      height:
                          screenSize.width < 600 ? 300 : screenSize.height / 2,
                      alignment: const Alignment(0, 0),
                      child: Container(
                        height: screenSize.width,
                        width: screenSize.width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/peach.png"),
                                fit: BoxFit.contain)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WebConstants().homeHeading(
                                'An Ambient Dining Experience',
                                themeProvider.darkMode),
                            WebConstants().constSpacing(20),
                            WebConstants().aboutSubHeading(
                                "Join us at the table as you dine for the perfect meal. We treat all of out customers with utmost care and service. Have a toast and enjoy out fine drinks while you're at it.",
                                themeProvider.darkMode),
                            WebConstants().constSpacing(20),
                            WebConstants().webButton(
                                'View Gallery', () {}, themeProvider.darkMode),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    sm: 6,
                    xs: 12,
                    child: Container(
                      height: screenSize.width >= 600
                          ? screenSize.height / 1.5
                          : screenSize.height / 2,
                      alignment: const Alignment(0, 0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80)),
                        child: Image.asset("assets/images/ambience.jpg"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.width < 600 ? 30 : screenSize.height / 30,
            ),
            // HOME PART 2
            Container(
              padding: EdgeInsets.only(
                  left: screenSize.width / 20,
                  right: screenSize.width / 20,
                  top: screenSize.width / 30,
                  bottom: screenSize.width / 30),
              color: themeProvider.darkMode
                  ? AppConstant.darkLightTextColors
                  : AppConstant.lightBg1,
              child: ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                    sm: 6,
                    xs: 12,
                    child: Visibility(
                      visible: screenSize.width > 576 ? true : false,
                      child: Column(
                        children: [
                          Container(
                            height: screenSize.height / 1.5,
                            alignment: const Alignment(0, 0),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(80),
                                  topRight: Radius.circular(80)),
                              child: Image.asset("assets/images/pulihora.jpg"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    sm: 6,
                    xs: 12,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: screenSize.width > 1240
                              ? screenSize.width / 10
                              : 20),
                      height: screenSize.width < 600
                          ? 300
                          : screenSize.height / 1.5,
                      alignment: const Alignment(0, 0),
                      child: SizedBox(
                        width: screenSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WebConstants().homeHeading(
                                'The Finest Indian Cuisine',
                                themeProvider.darkMode),
                            WebConstants().constSpacing(20),
                            WebConstants().aboutSubHeading(
                                "At Ruchulu, we thrive at creating the best Indian dish. With over 50 dishes to choose from, explore what our menu has to offer.",
                                themeProvider.darkMode),
                            WebConstants().constSpacing(20),
                            WebConstants().webButton('Explore Menu', () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const WebMenu(),
                                ),
                              );
                            }, themeProvider.darkMode),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    sm: 6,
                    xs: 12,
                    child: Column(
                      children: [
                        Visibility(
                          visible: screenSize.width < 576 ? true : false,
                          child: Container(
                            alignment: const Alignment(0, 0),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(80),
                                  topRight: Radius.circular(80)),
                              child: Image.asset("assets/images/pulihora.jpg"),
                            ),
                          ),
                        ),
                        WebConstants().constSpacing(30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // HOME PART 3
            WebConstants().constSpacing(30),

            Container(
              padding: EdgeInsets.only(
                  left: screenSize.width / 20,
                  right: screenSize.width / 20,
                  bottom: screenSize.width / 20),
              child: ResponsiveGridRow(
                children: [
                  ResponsiveGridCol(
                    sm: 6,
                    xs: 12,
                    child: Container(
                      padding: EdgeInsets.only(
                          left: screenSize.width > 1240
                              ? screenSize.width / 10
                              : 0),
                      height: screenSize.width < 600
                          ? 300
                          : screenSize.height / 1.2,
                      alignment: const Alignment(0, 0),
                      child: SizedBox(
                        height: screenSize.width,
                        width: screenSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WebConstants().homeHeading(
                                'Traditional & Family Recipes',
                                themeProvider.darkMode),
                            WebConstants().constSpacing(20),
                            WebConstants().aboutSubHeading(
                                "Recipes that have been passed down through generations, using local ingredients fresh from the farmers. We offer food that are often simple, hearty, and designed to be shared among families and friends, further strengthening bonds and creating a sence of community",
                                themeProvider.darkMode),
                            WebConstants().constSpacing(20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ResponsiveGridCol(
                    sm: 6,
                    xs: 12,
                    child: Container(
                      height: screenSize.width >= 600
                          ? screenSize.height / 1.5
                          : screenSize.height / 2,
                      alignment: const Alignment(0, 0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(80),
                            bottomRight: Radius.circular(80)),
                        child: Image.asset("assets/images/main.jpg"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget desktopScreen() {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenSize.width / 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/peach.png"),
                          fit: BoxFit.contain)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'An Ambient Dining Experience',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: screenSize.width / 25,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                      WebConstants().constSpacing(20),
                      Text(
                        "Join us at the table as you dine for the perfect meal. We treat all of out customers with utmost care and service. Have a toast and enjoy out fine drinks while you're at it.",
                        style: TextStyle(
                            color: AppConstant.lightAccent, fontSize: 18),
                      ),
                      WebConstants().constSpacing(20),
                      Row(
                        children: [
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppConstant.darkBg)),
                                onPressed: () {},
                                child: const Text('View Gallery')),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
                Expanded(
                  child: Container(
                    height: 500,
                    alignment: const Alignment(0, 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80)),
                      child: Image.asset("assets/images/ambience.jpg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          WebConstants().constSpacing(screenSize.height / 20),
          Container(
            width: screenSize.width,
            color: AppConstant.darkSecondary,
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width / 10, vertical: 30),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 430,
                    alignment: const Alignment(0, 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          topRight: Radius.circular(80)),
                      child: Image.asset("assets/images/pulihora.jpg"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "The Finest Indian Cuisine",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.playfairDisplay(
                            color: Colors.black,
                            fontSize: screenSize.width / 25,
                            height: 1.1,
                            fontWeight: FontWeight.bold),
                      ),
                      WebConstants().constSpacing(10),
                      SizedBox(
                        width: screenSize.width / 3,
                        child: Text(
                          "At Ruchulu, we thrive at creating the best Indian dish. With over 50 dishes to choose from, explore what our menu has to offer.",
                          style: TextStyle(
                            color: AppConstant.lightTextColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      WebConstants().constSpacing(10),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppConstant.darkBg)),
                            onPressed: () {},
                            child: const Text('Explore Menu')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          WebConstants().constSpacing(screenSize.height / 20),
          Container(
            width: screenSize.width,
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width / 10, vertical: 30),
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenSize.width / 2,
                        child: Text(
                          'Traditional & Family Recipes',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.playfairDisplay(
                              color: Colors.black,
                              fontSize: screenSize.width / 25,
                              height: 1.1,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      WebConstants().constSpacing(10),
                      SizedBox(
                        width: screenSize.width / 3,
                        child: Text(
                          "Recipes that have been passed down through generations, using local ingredients fresh from the farmers. We offer food that are often simple, hearty, and designed to be shared among families and friends, further strengthening bonds and creating a sence of community",
                          style: TextStyle(
                            color: AppConstant.lightTextColor,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      WebConstants().constSpacing(10),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppConstant.darkBg)),
                            onPressed: () {},
                            child: const Text('Explore Menu')),
                      ),
                    ],
                  ),
                  Container(
                    height: 430,
                    alignment: const Alignment(0, 0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          topRight: Radius.circular(80)),
                      child: Image.asset("assets/images/main.jpg"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
