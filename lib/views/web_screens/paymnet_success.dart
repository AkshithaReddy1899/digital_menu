import 'package:digital_menu/views/web_screens/web_menu.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/app_constants.dart';
import '../../controller/riverpod_management.dart';
import '../../main.dart';

class PaymentSuccess extends ConsumerStatefulWidget {
  const PaymentSuccess({super.key});

  @override
  ConsumerState<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends ConsumerState<PaymentSuccess> {
  bool loading = true;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final themeProvider = ref.watch(themeRiverpod);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          color: themeProvider.darkMode
              ? AppConstant.darkBg1
              : AppConstant.lightBg,
          padding: EdgeInsets.only(
              left: screenSize.width / 20, right: screenSize.width / 20),
          child: loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: themeProvider.darkMode
                          ? AppConstant.darkAccent
                          : AppConstant.lightAccent,
                      strokeWidth: 3,
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Payment success! Your order has been placed',
                      style: TextStyle(
                          color: themeProvider.darkMode
                              ? AppConstant.darkAccent
                              : AppConstant.lightAccent,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: screenSize.height / 30
                    ),
                    Container(
                      width: screenSize.width / 1.2,
                      child: AppConstant()
                          .elevatedButton(themeProvider.darkMode, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }, "Go Back To Home"),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
