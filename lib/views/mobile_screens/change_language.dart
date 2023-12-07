import 'package:digital_menu/controller/riverpod_management.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../common/app_constants.dart';

class ChangeLanguage extends ConsumerStatefulWidget {
  const ChangeLanguage({super.key});

  @override
  ConsumerState<ChangeLanguage> createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends ConsumerState<ChangeLanguage> {
  String? language;

  List languages = [
    {
      "language": "عربي",
      "code": "ar",
    },
    {
      "language": "English",
      "code": "en",
    },
    {
      "language": "हिंदी",
      "code": "hi",
    },
    {
      "language": "తెలుగు",
      "code": "te",
    },
    {
      "language": "Española",
      "code": "es",
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeRiverpod);
    language = themeProvider.lan;
    return Scaffold(
      appBar: AppConstant().mobileAppBarWithLabel(
        themeProvider.darkMode,
        AppLocalizations.of(context)!.pick,
      ),
      body: SafeArea(
        child: Container(
          color:
              themeProvider.darkMode ? AppConstant.darkBg : AppConstant.lightBg,
          child: ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              return RadioListTile(
                title: Text(
                  languages[index]["language"],
                  style: TextStyle(
                      color: themeProvider.darkMode
                          ? AppConstant.darkAccent
                          : AppConstant.lightAccent),
                ),
                value: languages[index]["code"],
                groupValue: language ?? 'en',
                fillColor: MaterialStateColor.resolveWith(
                  (states) => themeProvider.darkMode
                      ? AppConstant.darkAccent
                      : AppConstant.lightAccent,
                ),
                onChanged: (value) {
                  themeProvider.setLan(value.toString());
                  language = themeProvider.lan;
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
