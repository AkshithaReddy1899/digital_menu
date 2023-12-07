import 'package:countup/countup.dart';
import 'package:digital_menu/views/mobile_screens/category.dart';
import 'package:digital_menu/views/mobile_screens/contact_support.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/app_constants.dart';
import '../../model/response_model.dart';
import '../../controller/riverpod_management.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  List<Param> pendingOrders = [];
  List<Param> currentOrders = [];
  List<Param> servedOrders = [];

  List<Orders> orders = [];
  List<Orders> onGoingOrders = [];
  List arrAppicationData = [];

  final myProducts = List<String>.generate(1000, (i) => 'Product $i');

  bool loading = true;

  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  fetchOrders() async {
    if (mounted) {
      setState(() {
        loading = true;
        orders.clear();
        pendingOrders.clear();
        currentOrders.clear();
        servedOrders.clear();
        onGoingOrders.clear();
      });
    }
    ResponseModel response = await AppConstant().getAll(
        "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/order");

    for (var i = 0; i < orders.length; i++) {
      for (var j = 0; j < orders[i].items!.length; j++) {
        if (orders[i].items![j].orderStatus == 'Placed') {
          pendingOrders.add(orders[i].items![j]);
        } else if (orders[i].items![j].orderStatus == 'Accepted') {
          currentOrders.add(orders[i].items![j]);
        }
      }
    }
    if (mounted) {
      setState(() {
        if (response.object != null) {
          orders = response.object!.orders!;
        }

        pendingOrders = pendingOrders;
        currentOrders = currentOrders;
        servedOrders = servedOrders;
        onGoingOrders = onGoingOrders;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final themeProvider = ref.watch(themeRiverpod);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                  height: screenSize.height - kToolbarHeight,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: themeProvider.darkMode
                          ? AppConstant.darkBg
                          : AppConstant.lightBg),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'logo',
                            style: AppConstant().logoTextStyle(
                              themeProvider.darkMode == true
                                  ? AppConstant.darkAccent
                                  : AppConstant.lightAccent,
                            ),
                          ),
                          Icon(
                            Icons.notifications,
                            size: 35,
                            color: themeProvider.darkMode
                                ? AppConstant.darkAccent
                                : AppConstant.lightAccent,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenSize.height / 30,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: themeProvider.darkMode
                                      ? AppConstant.darkPrimary
                                      : AppConstant.lightPrimary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hello, Team!',
                                    style: AppConstant().poppinsText(
                                        20.0,
                                        FontWeight.bold,
                                        themeProvider.darkMode
                                            ? AppConstant.darkAccent
                                            : AppConstant.lightAccent),
                                  ),
                                  SizedBox(
                                    height: screenSize.height / 90,
                                  ),
                                  Text(
                                    'Your total number of orders...',
                                    style: TextStyle(
                                        color: themeProvider.darkMode
                                            ? AppConstant.darkSecondary
                                            : AppConstant.lightTextColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Countup(
                                    begin: 0,
                                    end: 99,
                                    duration: const Duration(seconds: 3),
                                    style: GoogleFonts.spaceMono(
                                      textStyle: TextStyle(
                                        fontSize: 50,
                                        color: themeProvider.darkMode
                                            ? AppConstant.darkAccent
                                            : AppConstant.lightAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height / 40,
                            ),
                            Divider(
                              color: themeProvider.darkMode
                                  ? AppConstant.darkAccent
                                  : AppConstant.lightAccent,
                            ),
                            SizedBox(
                              height: screenSize.height / 30,
                            ),
                            Text(
                              'Quick Links',
                              style: TextStyle(
                                  color: themeProvider.darkMode
                                      ? AppConstant.darkAccent
                                      : AppConstant.lightAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                            SizedBox(
                              height: screenSize.height / 40,
                            ),
                            Center(
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                spacing: 5,
                                runAlignment: WrapAlignment.center,
                                runSpacing: 2,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  AppConstant().containerWithLabelComponent(
                                    themeProvider.darkMode,
                                    () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CRUDCategory()));
                                    },
                                    Icons.category,
                                    'Category',
                                  ),
                                  AppConstant().containerWithLabelComponent(
                                    themeProvider.darkMode,
                                    () {
                                      themeProvider.toggleDarkMode(
                                          !themeProvider.darkMode);
                                    },
                                    themeProvider.darkMode
                                        ? Icons.dark_mode
                                        : Icons.sunny,
                                    'Change theme',
                                  ),
                                  AppConstant().containerWithLabelComponent(
                                    themeProvider.darkMode,
                                    () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ContactSupport(),
                                        ),
                                      );
                                    },
                                    Icons.settings,
                                    'Support',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height / 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.7,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 0.05 * screenSize.height,
                        left: 0.02 * screenSize.width,
                        right: 0.02 * screenSize.width),
                    height: 0.75 * screenSize.height,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      color: themeProvider.darkMode
                          ? AppConstant.darkBg1
                          : AppConstant.lightBg1,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5.0,
                          spreadRadius: 10.0,
                          offset: const Offset(0.0, 5.0),
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                    ),
                    child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorWeight: 2,
                            indicatorColor: themeProvider.darkMode
                                ? AppConstant.darkAccent
                                : const Color(0xff212121),
                            labelColor: themeProvider.darkMode
                                ? AppConstant.darkAccent
                                : const Color(0xff212121),
                            unselectedLabelColor: themeProvider.darkMode
                                ? AppConstant.darkSecondary
                                : const Color(0xff757575),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 2,
                            ),
                            onTap: (value) {
                              if (mounted) {
                                setState(() {
                                  selectedIndex = value;
                                });
                              }
                            },
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 2,
                            ),
                            tabs: const [
                              Tab(
                                text: 'Pending',
                              ),
                              Tab(
                                text: 'Current',
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenSize.height / 30,
                          ),
                          SizedBox(
                            height: screenSize.height / 90,
                          ),
                          Expanded(
                            child: Container(
                              width: screenSize.width,
                              height: 400,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TabBarView(
                                children: [
                                  loading == true
                                      ? AppConstant().loadingShimmer(
                                          themeProvider.darkMode)
                                      : pendingOrders.isNotEmpty
                                          ? ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: pendingOrders.length,
                                              itemBuilder: (context, index) {
                                                return AppConstant().ordersItem(
                                                    context,
                                                    pendingOrders,
                                                    index,
                                                    themeProvider.darkMode,
                                                    "Placed", () async {
                                                  Param obj = Param(
                                                    id: pendingOrders[index].id,
                                                    ordersId:
                                                        pendingOrders[index]
                                                            .ordersId,
                                                    orderStatus: "Accepted",
                                                  );
                                                  ResponseModel result =
                                                      await AppConstant()
                                                          .orderUpdate(context,
                                                              true, obj);

                                                  if (result.message ==
                                                      "Success!") {
                                                    fetchOrders();
                                                  }
                                                }, () async {
                                                  Param obj = Param(
                                                    id: pendingOrders[index].id,
                                                    ordersId:
                                                        pendingOrders[index]
                                                            .ordersId,
                                                    orderStatus: "Accepted",
                                                  );
                                                  ResponseModel result =
                                                      await AppConstant()
                                                          .orderUpdate(context,
                                                              true, obj);

                                                  if (result.message ==
                                                      "Success!") {
                                                    fetchOrders();
                                                  }
                                                });
                                              },
                                            )
                                          : AppConstant().noOrders(screenSize),
                                  loading == true
                                      ? AppConstant().loadingShimmer(
                                          themeProvider.darkMode)
                                      : currentOrders.isNotEmpty
                                          ? ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemCount: currentOrders.length,
                                              itemBuilder: (context, index) {
                                                return AppConstant().ordersItem(
                                                  context,
                                                  currentOrders,
                                                  index,
                                                  themeProvider.darkMode,
                                                  "Accepted",
                                                  () async {
                                                    Param obj = Param(
                                                      id: currentOrders[index]
                                                          .id,
                                                      ordersId:
                                                          currentOrders[index]
                                                              .ordersId,
                                                      orderStatus: "Served",
                                                    );
                                                    ResponseModel result =
                                                        await AppConstant()
                                                            .orderUpdate(
                                                                context,
                                                                true,
                                                                obj);

                                                    if (result.message ==
                                                        "Success!") {
                                                      fetchOrders();
                                                    }
                                                  },
                                                  () async {
                                                    Param obj = Param(
                                                      id: currentOrders[index]
                                                          .id,
                                                      ordersId:
                                                          currentOrders[index]
                                                              .ordersId,
                                                      orderStatus: "Served",
                                                    );
                                                    ResponseModel result =
                                                        await AppConstant()
                                                            .orderUpdate(
                                                                context,
                                                                true,
                                                                obj);

                                                    if (result.message ==
                                                        "Success!") {
                                                      fetchOrders();
                                                    }
                                                  },
                                                );
                                              },
                                            )
                                          : AppConstant().noOrders(screenSize),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
