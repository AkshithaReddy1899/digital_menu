import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';

import '../model/response_model.dart';

class AppConstant {
  static var darkAccent = const Color(0xfff0ece9);
  static var darkBg = const Color(0xff211521);
  static var darkBg1 = const Color(0xff4d434d);
  static var darkPrimary = const Color(0xff797279);
  static var darkSecondary = const Color(0xffD9D9D9);
  static var darkTextColor = const Color(0xff999699);
  static var darkLightTextColors = const Color(0xff140906);

  static var lightAccent = const Color(0xff211521);
  static var lightBg = const Color(0xfff0ece9);
  static var lightBg1 = const Color(0xffe5e6e4);
  static var lightPrimary = const Color(0xffcecbc2);
  static var lightSecondary = const Color.fromARGB(161, 139, 131, 117);
  static var lightTextColor = const Color(0xff030308);
  static var lightdarkTextColors = const Color(0xffc2b7a2);

  commonText(String label,
      [double? size,
      FontWeight? weight,
      Color? color,
      double? spacing,
      double? height,
      TextAlign? align]) {
    return Text(
      label,
      style: GoogleFonts.workSans(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: spacing,
          height: height,
          color: color),
      textAlign: align,
    );
  }

  appSubHeader(isDark, label) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
              width: 2,
              color: isDark ? AppConstant.darkAccent : AppConstant.lightAccent),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: isDark ? AppConstant.darkAccent : AppConstant.lightAccent),
      ),
    );
  }

  appSideHeader(isDark, label) {
    return Text(
      label,
      style: GoogleFonts.workSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color:
              isDark ? AppConstant.darkTextColor : AppConstant.lightTextColor),
    );
  }

  mobileAppBarWithLabel(isDark, label) {
    return AppBar(
      iconTheme: IconThemeData(
          color: isDark ? AppConstant.darkAccent : AppConstant.lightAccent),
      backgroundColor: isDark ? AppConstant.darkBg : AppConstant.lightBg,
      title: Text(
        label,
        style: TextStyle(
            color: isDark ? AppConstant.darkAccent : AppConstant.lightAccent),
      ),
    );
  }

  logoTextStyle(color) {
    return GoogleFonts.questrial(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
        color: color);
  }

  poppinsText(size, weight, color) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }

  var commonTextField = (controller, label, keyboard, isDark) {
    return TextFormField(
      controller: controller,
      validator: (controller) {
        if (controller!.isEmpty) {
          return 'Please enter a name';
        } else {
          return null;
        }
      },
      keyboardType: keyboard,
      style: TextStyle(color: isDark ? darkSecondary : lightAccent),
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(
            color: isDark
                ? AppConstant.lightdarkTextColors
                : AppConstant.lightAccent),
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: isDark ? AppConstant.darkPrimary : AppConstant.lightPrimary,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 229, 115, 115)),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 3, 75, 109)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  };

  elevatedButton(
    isDark,
    onPressed,
    text,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(2),
        backgroundColor: MaterialStateProperty.all(
            isDark ? AppConstant.darkAccent : AppConstant.lightAccent),
      ),
      child: Text(
        text,
        style: TextStyle(
            color:
                isDark ? AppConstant.darkLightTextColors : AppConstant.lightBg,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  containerWithLabelComponent(isDark, onPressed, IconData icon, String label) {
    return SizedBox(
      width: 90,
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15.0),
                ),
                color: isDark ? AppConstant.darkBg1 : AppConstant.lightPrimary,
              ),
              child: Icon(
                icon,
                color: isDark
                    ? AppConstant.darkSecondary
                    : AppConstant.lightAccent,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isDark
                    ? AppConstant.darkTextColor
                    : AppConstant.lightTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlert(context, title, content, buttonText, [buttonYes, onpressed]) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(buttonText),
            ),
            TextButton(
              onPressed: onpressed,
              child: Text(buttonYes),
            ),
          ],
        );
      },
    );
  }

  choicechip(array, selectedIndex, onSelect, index) {
    return ChoiceChip(
      labelPadding: const EdgeInsets.all(2.0),
      label: Text(
        array[index],
      ),
      selected: selectedIndex == index,
      selectedColor: AppConstant.darkAccent,
      onSelected: onSelect,
      elevation: 1,
    );
  }

  ordersItem(context, orders, index, isDark, status, acceptOrder, servedOrder) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 100,
        minWidth: double.infinity,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isDark ? AppConstant.darkBg : AppConstant.lightBg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order id: ${orders[index].id}',
                style: const TextStyle(
                  fontSize: 10,
                ),
              ),
              Text('Portions: ${orders[index].quantity}'),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    orders[index].name.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible: orders[index].customization != "",
                child: Text(
                  orders[index].customization.toString(),
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
          Row(
            children: [
              Visibility(
                visible: status == 'Placed',
                child: elevatedButton(isDark, acceptOrder, 'Accept order'),
              ),
              Visibility(
                visible: status == 'Accepted',
                child: elevatedButton(isDark, servedOrder, 'Ready to serve'),
              ),
            ],
          )
        ],
      ),
    );
  }

  ordersList(isDark, List<Orders> orders, index, visible) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 100,
        minWidth: double.infinity,
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDark ? AppConstant.darkBg1 : AppConstant.lightBg1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order id: ${orders[index].ordersId}',
                style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppConstant.darkAccent
                        : AppConstant.lightAccent),
              ),
              Text(
                'DateTime: ${orders[index].dateTime}',
                style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppConstant.darkAccent
                        : AppConstant.lightAccent),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: orders[index].items!.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orders[index].items![i].name.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppConstant.darkSecondary
                              : AppConstant.lightAccent),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      'Portions: ${orders[index].items![i].quantity}',
                      style: TextStyle(
                          fontSize: 10,
                          color: isDark
                              ? AppConstant.darkSecondary
                              : AppConstant.lightAccent),
                    ),
                  ],
                ),
              );
            },
          ),
          Visibility(
            visible: visible,
            child:
                AppConstant().elevatedButton(isDark, () {}, 'Generate QR code'),
          ),
        ],
      ),
    );
  }

  // REMOVE after implementing loading animation in past orders
  // loading(Size screenSize) {
  //   return SizedBox(
  //     width: screenSize.width,
  //     height: screenSize.height / 2,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         LoadingAnimationWidget.beat(
  //           color: AppConstant.darkBg,
  //           size: screenSize.width / 6,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  loadingShimmer(isDark) {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: isDark ? AppConstant.darkBg : AppConstant.lightPrimary,
        highlightColor: isDark ? AppConstant.darkBg1 : AppConstant.lightBg,
        child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const SizedBox(height: 100),
            );
          },
        ),
      ),
    );
  }

  menuCard() {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: const SizedBox(
        height: 35,
        width: 70,
      ),
    );
  }

  loadingShimmerMenu(isDark) {
    return Expanded(
      child: Shimmer.fromColors(
          baseColor:
              isDark ? AppConstant.darkPrimary : AppConstant.lightPrimary,
          highlightColor: isDark ? AppConstant.darkBg1 : AppConstant.lightBg,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuCard(),
                  menuCard(),
                  menuCard(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const SizedBox(height: 100),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

  noOrders(Size screenSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'No Orders',
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        SizedBox(
          height: screenSize.height / 30,
        ),
        SvgPicture.asset(
          'assets/images/loading.svg',
          width: 100,
        )
      ],
    );
  }

  LinearGradient shimmerGradient = const LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  // API CALLS

  postUpdate(context, bisUpdate, obj, id) async {
    Response response = bisUpdate == false
        ? await post(
            Uri.parse(
                "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/menu"),
            headers: {"content-type": "application/json"},
            body: jsonEncode(obj),
          )
        : await put(
            Uri.parse(
                "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/menu$id"),
            headers: {"content-type": "application/json"},
            body: jsonEncode(obj),
          );

    if (response.statusCode == 200) {
      ResponseModel result = ResponseModel.fromJson(jsonDecode(response.body));
      return result;
    } else {
      SnackBar snackBar = SnackBar(
        content: Text(
            "There was an error while ${bisUpdate ? "updating" : "adding"} the item, please try again later"),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  orderUpdate(context, bisUpdate, Param obj) async {
    Response response = await put(
      Uri.parse(
          "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/order/${obj.ordersId}"),
      headers: {"content-type": "application/json"},
      body: jsonEncode(obj),
    );

    if (response.statusCode != 200) {
      SnackBar snackBar = const SnackBar(
          content: Text(
              'There was an error while changing the order status , please try again later'));
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      ResponseModel result = ResponseModel.fromJson(jsonDecode(response.body));
      return result;
    }
  }

  Future getAll(url) async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      ResponseModel getResponse =
          ResponseModel.fromJson(jsonDecode(response.body));
      return getResponse;
    } else {
      ResponseModel response =
          ResponseModel(message: 'Error fetching the categories');
      return response;
    }
  }
}
