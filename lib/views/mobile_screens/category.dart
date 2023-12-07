import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';

import '../../common/app_constants.dart';
import '../../controller/riverpod_management.dart';
import '../../model/response_model.dart';

class CRUDCategory extends ConsumerStatefulWidget {
  const CRUDCategory({super.key});

  @override
  ConsumerState<CRUDCategory> createState() => _CRUDCategoryState();
}

class _CRUDCategoryState extends ConsumerState<CRUDCategory> {
  List<dynamic> categories = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    context.loaderOverlay.show();
    setState(() {
      loading = true;
    });
    ResponseModel response = await AppConstant().getAll(
        "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/categories");
    categories = response.object!.categories!;
    setState(() {
      categories = response.object!.categories!;
      loading = false;
    });
    if (!context.mounted) return;
    context.loaderOverlay.hide();
  }

  postUpdate(bisUpdate, obj, categoryName) async {
    Response response = bisUpdate == false
        ? await post(
            Uri.parse(
                "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/categories"),
            headers: {"content-type": "application/json"},
            body: jsonEncode(obj),
          )
        : await put(
            Uri.parse(
                "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/categories/$categoryName"),
            headers: {"content-type": "application/json"},
            body: jsonEncode(obj),
          );
    ResponseModel result = ResponseModel.fromJson(jsonDecode(response.body));

    if (response.statusCode == 200) {
      setState(() {
        categories = result.object!.categories!;
      });
      return result;
    } else {
      SnackBar snackbar = SnackBar(
        content: Text(
            'There was an error while ${bisUpdate ? "updating" : "adding"} the category. Please try again later. '),
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  openBottomModalSheet(bool bisUpdate, isDark, currentCategory) {
    if (bisUpdate == true) {
      categoryController.text = currentCategory;
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
                    AppConstant().commonTextField(
                        categoryController,
                        "Enter Category Name",
                        TextInputType.emailAddress,
                        isDark),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        AppConstant().elevatedButton(
                          isDark,
                          () async {
                            context.loaderOverlay.show();
                            Param obj = Param(
                              categoryName: categoryController.text,
                            );

                            ResponseModel response = await postUpdate(bisUpdate,
                                obj, bisUpdate ? currentCategory : "");

                            if (response.message == 'Success!') {
                              setState(() {
                                loading = true;
                              });
                              if (!context.mounted) return;
                              Navigator.pop(context);
                              categoryController.clear();

                              setState(() {
                                categories = response.object!.categories!;
                                loading = false;
                              });
                              context.loaderOverlay.hide();
                            } else {
                              if (!context.mounted) return;
                              AppConstant().showAlert(
                                  context,
                                  'Error',
                                  "There was an error while ${bisUpdate ? "updating" : "adding"} the category, Please try again later :(",
                                  "OK");
                            }
                          },
                          bisUpdate ? "Update" : "Submit",
                        ),
                        const SizedBox(
                          height: 20,
                          width: 20,
                        ),
                        AppConstant().elevatedButton(isDark, () async {
                          if (_formKey.currentState!.validate()) {
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
                                      "https://willowy-creponne-213742.netlify.app/.netlify/functions/api/categories/${categoryController.text}"),
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
                                    categories =
                                        getMenuResponse.object!.categories!;
                                    loading = false;
                                  });
                                } else {
                                  const snackBar = SnackBar(
                                    content: Text(
                                        "There was an error while deleting this category, please try again later"),
                                  );
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                                if (loading == false) {
                                  Navigator.pop(context);
                                }
                                context.loaderOverlay.hide();
                              },
                            );
                          } else {
                            SnackBar snackBar = const SnackBar(
                              content: Text("Category can't be empty."),
                            );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
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
    return Scaffold(
      appBar: AppConstant()
          .mobileAppBarWithLabel(themeProvider.darkMode, 'Category'),
      body: SafeArea(
        child: Container(
          color: themeProvider.darkMode
              ? AppConstant.darkBg1
              : AppConstant.lightBg1,
          padding: EdgeInsets.all(screenSize.width / 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              categories.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 50,
                            margin: const EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: () {
                                openBottomModalSheet(true,
                                    themeProvider.darkMode, categories[index]);
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: themeProvider.darkMode
                                      ? AppConstant.darkPrimary
                                      : AppConstant.lightPrimary,
                                  padding: const EdgeInsets.only(left: 20),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  alignment: Alignment.centerLeft),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AppConstant().appSideHeader(
                                      themeProvider.darkMode,
                                      categories[index]),
                                  Icon(
                                    Icons.arrow_right,
                                    color: themeProvider.darkMode
                                        ? AppConstant.darkAccent
                                        : AppConstant.lightAccent,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Shimmer.fromColors(
                        baseColor: themeProvider.darkMode
                            ? AppConstant.darkBg
                            : AppConstant.lightPrimary,
                        highlightColor: themeProvider.darkMode
                            ? AppConstant.darkBg1
                            : AppConstant.lightBg,
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 1.0,
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: const SizedBox(height: 50),
                            );
                          },
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppConstant.darkBg,
        child: const Icon(Icons.add),
        onPressed: () {
          openBottomModalSheet(false, themeProvider.darkMode, "");
        },
      ),
    );
  }
}
