import 'dart:convert';

import 'package:digital_menu/views/mobile_screens/category.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../common/components/menu.dart';
import '../../common/app_constants.dart';
import '../../model/response_model.dart';
import '../../controller/riverpod_management.dart';

class MenuScreen extends ConsumerStatefulWidget {
  const MenuScreen({super.key});

  @override
  ConsumerState<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends ConsumerState<MenuScreen> {
  List<dynamic> categories = [];
  List<Param> menuItems = [];

  List<DropdownMenuItem> categoriesList = [];
  int selectedCategoryIndex = 0;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool loading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  fetchData() async {
    setState(() {
      loading = true;
    });
    ResponseModel response = await AppConstant().getAll(
        "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/categories");

    setState(() {
      categories = response.object!.categories!;
    });

    getCategoriesDropDown();

    if (categories.isNotEmpty) {
      setState(() {
        loading = false;
      });
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
        child: categoriesList.isNotEmpty
            ? Wrap(
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
                              // color: Colors.blueGrey[100],
                              color: isDark
                                  ? AppConstant.darkPrimary
                                  : AppConstant.lightPrimary,
                            ),
                            child: DropdownButton(
                              hint: const Text('Select Category'),
                              items: categoriesList,
                              style: TextStyle(
                                  color: isDark
                                      ? AppConstant.darkAccent
                                      : AppConstant.lightTextColor),
                              value: categories[selectedCategoryIndex],
                              onChanged: (value) {
                                setState(() {
                                  categories[selectedCategoryIndex] = value;
                                });
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
                          AppConstant().commonTextField(nameController,
                              "Enter Name", TextInputType.emailAddress, isDark),
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
                                  categoryName:
                                      categories[selectedCategoryIndex],
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  price: int.parse(priceController.text),
                                );

                                ResponseModel response = await AppConstant()
                                    .postUpdate(context, bisUpdate, obj,
                                        bisUpdate ? id : "");

                                if (response.message == 'Success!') {
                                  setState(() {
                                    loading = true;
                                  });
                                  if (!context.mounted) return;
                                  Navigator.pop(context);
                                  priceController.clear();
                                  descriptionController.clear();
                                  nameController.clear();

                                  setState(() {
                                    menuItems = response.object!.menu!;
                                    loading = false;
                                  });
                                } else {
                                  if (!context.mounted) return;
                                  AppConstant().showAlert(
                                      context,
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
                                      setState(() {
                                        loading = true;
                                      });

                                      if (!context.mounted) return;
                                      Navigator.pop(context);

                                      ResponseModel getMenuResponse =
                                          ResponseModel.fromJson(
                                              jsonDecode(response.body));
                                      setState(() {
                                        menuItems =
                                            getMenuResponse.object!.menu!;
                                        loading = false;
                                      });
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
              )
            : SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  color: isDark
                      ? AppConstant.darkBg1
                      : AppConstant.darkSecondary,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'There are no categories please add a category to proceed',
                          style: TextStyle(
                              color: isDark
                                  ? AppConstant.lightBg
                                  : AppConstant.darkBg1),
                        ),
                        AppConstant().elevatedButton(isDark, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CRUDCategory()));
                        }, "Add a new category")
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeRiverpod);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height - kToolbarHeight,
          child: const MenuCard(),
        ),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          backgroundColor: AppConstant.darkAccent,
          foregroundColor: AppConstant.darkBg,
          child: const Icon(Icons.add),
          onPressed: () {
            openBottomModalSheet(false, themeProvider.darkMode, "", "", 0, "");
          },
        ),
      ),
    );
  }
}
