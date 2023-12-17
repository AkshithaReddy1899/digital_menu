import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../controller/riverpod_management.dart';
import '../app_constants.dart';
import '../../model/response_model.dart';

class MenuCard extends ConsumerStatefulWidget {
  const MenuCard({super.key});

  @override
  ConsumerState<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends ConsumerState<MenuCard> {
  bool loading = false;
  List<dynamic> categories = [];
  List<Param> menuItems = [];
  final _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem> categoriesList = [];
  int selectedCategoryIndex = 0;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    ResponseModel response = await AppConstant().getAll(
        "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/categories");

    ResponseModel menuResponse = await AppConstant().getAll(
        "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/menu");
    if (mounted) {
      setState(() {
        categories = response.object!.categories!;
        menuItems = menuResponse.object!.menu!;
        // categories = ['Main', 'Startes', 'Drinks', 'Desserts'];
      });
    }

    getCategoriesDropDown();

    if (categories.isNotEmpty && menuItems.isNotEmpty) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  postUpdate(bisUpdate, obj, id) async {
    Response response = bisUpdate == false
        ? await post(
            Uri.parse(
                "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/menu"),
            headers: {"content-type": "application/json"},
            body: jsonEncode(obj),
          )
        : await put(
            Uri.parse(
                "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/menu/$id"),
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

  getCategoriesDropDown() {
    if (categoriesList.isEmpty) {
      for (var element in categories) {
        categoriesList.add(
          DropdownMenuItem(
            value: element,
            child: Text(element.toString()),
          ),
        );
      }
    }
  }

  addToCart(isDark, Param item) {
    item.quantity = 1;
    final cartProvider = ref.watch(cartRiverpod);
    cartProvider.addItemToCart(item);
    cartProvider.getTotalAmount();
    SnackBar snackBar =
        SnackBar(content: Text('${item.name} added to the cart'));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  openBottomModalSheet(bool bisUpdate, isDark, name, description, price, id) {
    if (bisUpdate == true) {
      nameController.text = name;
      descriptionController.text = description;
      priceController.text = price.toString();
    }
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [
            Container(
              color: isDark ? AppConstant.darkBg : AppConstant.lightBg,
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: isDark
                            ? AppConstant.darkPrimary
                            : AppConstant.lightPrimary,
                      ),
                      child: DropdownButton(
                        hint: const Text('Select Category'),
                        items: categoriesList,
                        value: categories[selectedCategoryIndex],
                        style: TextStyle(
                            color: isDark
                                ? AppConstant.darkAccent
                                : AppConstant.lightTextColor),
                        onChanged: (value) {
                          if (mounted) {
                            setState(() {
                              categories[selectedCategoryIndex] = value;
                            });
                          }
                        },
                        isExpanded: true,
                        dropdownColor: isDark
                            ? AppConstant.darkPrimary
                            : AppConstant.lightPrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppConstant().commonTextField(nameController, "Enter Name",
                        TextInputType.emailAddress, isDark),
                    const SizedBox(
                      height: 30,
                    ),
                    AppConstant().commonTextField(
                        descriptionController,
                        "Enter Description",
                        TextInputType.emailAddress,
                        isDark),
                    const SizedBox(
                      height: 30,
                    ),
                    AppConstant().commonTextField(priceController,
                        "Enter Price", TextInputType.number, isDark),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        AppConstant().elevatedButton(isDark, () async {
                          context.loaderOverlay.show();
                          Param obj = Param(
                            id: bisUpdate ? id : "",
                            categoryName: categories[selectedCategoryIndex],
                            name: nameController.text,
                            description: descriptionController.text,
                            price: int.parse(priceController.text),
                          );

                          ResponseModel response = await postUpdate(
                              bisUpdate, obj, bisUpdate ? id : "");

                          if (response.message == 'Success!') {
                            if (mounted) {
                              setState(() {
                                loading = true;
                              });
                            }
                            if (!context.mounted) return;
                            Navigator.pop(context);
                            priceController.clear();
                            descriptionController.clear();
                            nameController.clear();
                            if (mounted) {
                              setState(() {
                                menuItems = response.object!.menu!;
                                loading = false;
                              });
                            }
                          } else {
                            if (!context.mounted) return;
                            AppConstant().showAlert(
                                context,
                                isDark,
                                'Error',
                                "There was an error while ${bisUpdate ? "updating" : "adding"} the category, Please try again later :(",
                                "OK");
                          }
                          context.loaderOverlay.hide();
                        }, bisUpdate ? "Update" : "Submit"),
                        const SizedBox(
                          height: 20,
                          width: 20,
                        ),
                        AppConstant().elevatedButton(isDark, () async {
                          AppConstant().showAlert(
                            context,
                            isDark,
                            'Are you sure?',
                            "This action can't be undone",
                            'No',
                            'Yes',
                            () async {
                              context.loaderOverlay.show();
                              Response response = await delete(
                                Uri.parse(
                                    "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/menu/$id"),
                              );
                              if (response.statusCode == 200) {
                                if (mounted) {
                                  setState(() {
                                    loading = true;
                                  });
                                }

                                if (!context.mounted) return;
                                Navigator.pop(context);

                                ResponseModel getMenuResponse =
                                    ResponseModel.fromJson(
                                        jsonDecode(response.body));
                                if (mounted) {
                                  setState(() {
                                    menuItems = getMenuResponse.object!.menu!;
                                    loading = false;
                                  });
                                }
                              } else {
                                const snackBar = SnackBar(
                                  content: Text(
                                      "There was an error while deleting the item, please try again later"),
                                );
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              if (loading == false) {
                                Navigator.pop(context);
                                context.loaderOverlay.hide();
                              }
                            },
                          );
                        }, 'Delete'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final themeProvider = ref.watch(themeRiverpod);
    List<Param> filteredProducts = menuItems
        .where((Param product) =>
            product.categoryName == categories[selectedCategoryIndex])
        .toList();
    return Container(
      width: screenSize.width,
      height: screenSize.height - kToolbarHeight,
      padding: const EdgeInsets.all(10),
      decoration: kIsWeb
          ? const BoxDecoration(
              color: Colors.transparent,
            )
          : BoxDecoration(
              color: themeProvider.darkMode
                  ? AppConstant.darkBg
                  : AppConstant.lightBg,
            ),
      child: Column(
        children: [
          Text(
            "Today in the menu",
            style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: themeProvider.darkMode
                    ? AppConstant.darkAccent
                    : AppConstant.lightAccent),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 20),
          loading
              ? AppConstant().loadingShimmerMenu(themeProvider.darkMode)
              : Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45,
                        child: ListView(
                          primary: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            categories.isNotEmpty
                                ? Wrap(
                                    spacing: 10,
                                    runSpacing: 0.0,
                                    children: List.generate(categories.length,
                                        (index) {
                                      return ChoiceChip(
                                        shape: const RoundedRectangleBorder(
                                            side: BorderSide(width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4.0))),
                                        labelPadding: const EdgeInsets.all(1.0),
                                        label: Text(
                                          categories[index],
                                          style: GoogleFonts.workSans(
                                              color: selectedCategoryIndex ==
                                                      index
                                                  ? themeProvider.darkMode
                                                      ? AppConstant.lightAccent
                                                      : AppConstant.lightPrimary
                                                  : themeProvider.darkMode
                                                      ? AppConstant.darkAccent
                                                      : AppConstant.darkBg),
                                        ),
                                        backgroundColor: themeProvider.darkMode
                                            ? AppConstant.darkBg1
                                            : AppConstant.lightSecondary,
                                        selected:
                                            selectedCategoryIndex == index,
                                        selectedColor: kIsWeb
                                            ? themeProvider.darkMode
                                                ? AppConstant.lightBg
                                                : AppConstant.darkBg
                                            : themeProvider.darkMode
                                                ? AppConstant.darkAccent
                                                : AppConstant.darkBg1,
                                        onSelected: (value) {
                                          setState(() {
                                            selectedCategoryIndex = value
                                                ? index
                                                : selectedCategoryIndex;
                                          });
                                        },
                                        elevation: 1,
                                      );
                                    }),
                                  )
                                : const Text('Loading'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            Visibility(
                              visible: filteredProducts.isNotEmpty,
                              child: Expanded(
                                child: ListView.builder(
                                  itemCount: filteredProducts.length,
                                  itemBuilder: (context, index) {
                                    Param product = filteredProducts[index];
                                    return Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: kIsWeb
                                                ? themeProvider.darkMode
                                                    ? AppConstant.darkPrimary
                                                    : AppConstant.lightPrimary
                                                : themeProvider.darkMode
                                                    ? AppConstant.darkBg1
                                                    : AppConstant.lightPrimary,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  AppConstant().commonText(
                                                    product.name.toString(),
                                                    16,
                                                    FontWeight.w600,
                                                    themeProvider.darkMode
                                                        ? AppConstant.darkAccent
                                                        : AppConstant
                                                            .lightAccent,
                                                  ),
                                                  AppConstant().commonText(
                                                    "₹${product.price}",
                                                    20.0,
                                                    FontWeight.w400,
                                                    kIsWeb
                                                        ? themeProvider.darkMode
                                                            ? AppConstant
                                                                .darkSecondary
                                                            : AppConstant
                                                                .lightAccent
                                                        : themeProvider.darkMode
                                                            ? AppConstant
                                                                .darkSecondary
                                                            : AppConstant
                                                                .lightTextColor,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              AppConstant().commonText(
                                                product.description.toString(),
                                                14,
                                                FontWeight.w400,
                                                themeProvider.darkMode
                                                    ? AppConstant.darkSecondary
                                                    : AppConstant
                                                        .lightTextColor,
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: AppConstant()
                                                    .elevatedButton(
                                                        themeProvider.darkMode,
                                                        () {
                                                  kIsWeb
                                                      ? addToCart(
                                                          themeProvider
                                                              .darkMode,
                                                          product)
                                                      : openBottomModalSheet(
                                                          true,
                                                          themeProvider
                                                              .darkMode,
                                                          product.name,
                                                          product.description,
                                                          product.price,
                                                          product.id);
                                                },
                                                        kIsWeb
                                                            ? "Add to cart"
                                                            : "Edit or Delete"),
                                              )
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
                            ),
                            Visibility(
                              visible: filteredProducts.isEmpty,
                              child: Container(
                                padding: EdgeInsets.all(screenSize.width / 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppConstant.darkBg1,
                                ),
                                width: screenSize.width,
                                height: screenSize.height / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      kIsWeb
                                          ? "We regret to inform you that we aren't serving anything in this category "
                                          : 'There are no Items in this Category, Add a new item by clicking the add button on the bottom right of the screen',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppConstant.darkAccent,
                                          height: 1.2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
