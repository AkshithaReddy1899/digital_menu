import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:digital_menu/common/app_constant_web.dart';
import 'package:digital_menu/controller/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:html/dom.dart' as html_parser;

import '../../common/app_constants.dart';
import '../../common/components/menu.dart';

class WebMenu extends ConsumerStatefulWidget {
  const WebMenu({super.key});

  @override
  ConsumerState<WebMenu> createState() => _WebMenuState();
}

class _WebMenuState extends ConsumerState<WebMenu> {
  List<int> list = [1, 2, 3, 4, 5];
  List reviews = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/reviews.json');
    final data = await json.decode(response);

    setState(() {
      reviews = data["reviews"];
    });

  }

  @override
  void initState() {
    readJson();
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
      body: SingleChildScrollView(
        child: Container(
          color: themeProvider.darkMode
              ? AppConstant.darkBg1
              : AppConstant.lightBg1,
          padding: EdgeInsets.only(
            top: screenSize.width / 20,
            left: screenSize.width / 10,
            right: screenSize.width / 10,
          ),
          child: Column(
            children: [
              const MenuCard(),
              SizedBox(
                height: screenSize.height / 10,
              ),
              Text(
                "Reviews",
                style: GoogleFonts.playfairDisplay(
                    fontSize: 22,
                    fontWeight: FontWeight.normal,
                    color: themeProvider.darkMode
                        ? AppConstant.darkAccent
                        : AppConstant.lightAccent),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                child: CarouselSlider(
                  options: CarouselOptions(
                    animateToClosest: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    enableInfiniteScroll: true,
                  ),
                  items: reviews
                      .map(
                        (item) => SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: item["stars"] * 15,
                                  height: 20,
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: item["stars"],
                                          itemBuilder: (context, index) {
                                            return Text(
                                              html_parser.DocumentFragment.html(
                                                  "&#9733;")
                                                  .text
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.amber),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  item["text"],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 1.1,
                                      height: 1.5),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
