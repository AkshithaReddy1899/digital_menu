import 'package:digital_menu/common/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../controller/riverpod_management.dart';
import '../../model/response_model.dart';

class PastOrders extends ConsumerStatefulWidget {
  const PastOrders({super.key});

  @override
  ConsumerState<PastOrders> createState() => _PastOrdersState();
}

class _PastOrdersState extends ConsumerState<PastOrders> {
  List<Orders> orders = [];
  List<Orders> pastOrders = [];
  bool loading = false;

  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  fetchOrders() async {
    setState(() {
      orders.clear();
      pastOrders.clear();
      loading = true;
    });
    ResponseModel response = await AppConstant().getAll(
        "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/order");

    orders = response.object!.orders!;

    setState(() {
      orders = response.object!.orders!;
      pastOrders = pastOrders;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeRiverpod);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppConstant()
          .mobileAppBarWithLabel(themeProvider.darkMode, "Past Orders"),
      body: SafeArea(
        child: Container(
            width: screenSize.width,
            padding: const EdgeInsets.only(left: 20, right: 20),
            color: themeProvider.darkMode
                ? AppConstant.darkBg
                : AppConstant.lightBg,
            child: loading == false
                ? pastOrders.isNotEmpty
                    ? ListView.builder(
                        itemCount: pastOrders.length,
                        itemBuilder: (context, index) {
                          return AppConstant().ordersList(
                              themeProvider.darkMode, pastOrders, index, false);
                        },
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Something went wrong please try again later',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                : AppConstant().loadingShimmer(themeProvider.darkMode)),
      ),
    );
  }
}
