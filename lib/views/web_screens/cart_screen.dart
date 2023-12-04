import 'dart:convert';

import 'package:digital_menu/common/app_constant_web.dart';
import 'package:digital_menu/controller/riverpod_management.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

import '../../common/app_constants.dart';
import '../../model/response_model.dart';
import 'paymnet_success.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeRiverpod);
    final cartProvider = ref.watch(cartRiverpod);
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: WebConstants()
          .webAppBar(context, screenSize, themeProvider.darkMode, cartProvider),
      body: Container(
        color:
            themeProvider.darkMode ? AppConstant.darkBg1 : AppConstant.lightBg1,
        padding: const EdgeInsets.all(20),
        width: screenSize.width,
        height: screenSize.height,
        child: cartProvider.cartItems.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        Param product = cartProvider.cartItems[index];
                        return Column(
                          children: [
                            Container(
                              width: screenSize.width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kIsWeb
                                    ? themeProvider.darkMode
                                        ? AppConstant.darkPrimary
                                        : AppConstant.lightPrimary
                                    : AppConstant.darkSecondary,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppConstant().commonText(
                                            product.name.toString(),
                                            20,
                                            FontWeight.w300,
                                            themeProvider.darkMode
                                                ? const Color.fromARGB(
                                                    255, 240, 236, 236)
                                                : AppConstant.lightAccent,
                                          ),
                                          AppConstant().commonText(
                                            "\$${product.price}",
                                            screenSize.height / 60,
                                            FontWeight.w700,
                                            themeProvider.darkMode
                                                ? const Color.fromARGB(
                                                    255, 240, 236, 236)
                                                : AppConstant.lightAccent,
                                          )
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  cartProvider.increaseQuantity(
                                                      product);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: AppConstant
                                                        .lightSecondary,
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: AppConstant
                                                        .darkSecondary,
                                                  ),
                                                )),
                                            Text(
                                              product.quantity.toString(),
                                              style: TextStyle(
                                                  color: themeProvider.darkMode
                                                      ? AppConstant.lightBg
                                                      : AppConstant.darkBg,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                cartProvider
                                                    .decreaseQuantity(product);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: AppConstant
                                                      .lightSecondary,
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  color:
                                                      AppConstant.darkSecondary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppConstant().appSideHeader(
                                themeProvider.darkMode, 'Sub Total'),
                            // const Text("Sub Total"),
                            AppConstant().appSideHeader(themeProvider.darkMode,
                                cartProvider.totalPrice.toString()),
                            // Text(cartProvider.totalPrice.toString()),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppConstant().appSideHeader(
                                themeProvider.darkMode, 'Service Tax'),
                            AppConstant()
                                .appSideHeader(themeProvider.darkMode, '22'),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppConstant()
                                .appSideHeader(themeProvider.darkMode, 'Total'),
                            AppConstant().appSideHeader(themeProvider.darkMode,
                                '${cartProvider.totalPrice + 22}'),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: screenSize.width,
                          alignment: Alignment.bottomRight,
                          child: AppConstant()
                              .elevatedButton(themeProvider.darkMode, () async {
                            Orders obj = Orders();

                            List<Param> item = [];

                            for (var i = 0;
                                i < cartProvider.cartItems.length;
                                i++) {
                              cartProvider.cartItems[i].orderStatus = "Placed";
                              item.add(cartProvider.cartItems[i]);
                            }

                            obj.items = item;

                            Response response = await post(
                              Uri.parse(
                                  "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/order"),
                              headers: {"content-type": "application/json"},
                              body: jsonEncode(obj),
                            );
                            if (response.statusCode == 200) {
                              if (!context.mounted) return;
                              cartProvider.clearCart();
                              return Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaymentSuccess(),
                                ),
                              );
                            } else {
                              SnackBar snackBar = const SnackBar(
                                content: Text(
                                    "There was an error while placing the order, please try again later"),
                              );
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            // const CircularProgressIndicator(
                            //   color: Colors.white,
                            //   strokeWidth: 3,
                            // );
                          }, "Continue to make payment"),
                        ),
                        // PayView()
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: AppConstant().appSideHeader(themeProvider.darkMode,
                    'You have not added anything to the cart'),
              ),
      ),
    );
  }
}
