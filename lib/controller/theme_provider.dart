// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DarkModeNotifier extends StateNotifier<bool> {
//   DarkModeNotifier() : super(false);

//   void toggle() {
//     state = !state;
//   }
// }

// final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>(
//   (ref) => DarkModeNotifier(),
// );


// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'main_provider.dart';

// class ThemeNotifier extends StateNotifier {
//   ThemeNotifier(this.ref) : super(MainState.initial);

//   final Ref ref;

//   bool _darkMode = false;

//   bool get darkMode => _darkMode;

//   void toggleDarkMode(bool value) {
//     _darkMode = value;
//   }
// }

// final mainStateProvider =
//     StateNotifierProvider.autoDispose<MainStateNotifier, MainState>(
//   (ref) {
//     return MainStateNotifier(ref);
//   },
// );


import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _darkMode = false;

  String lan = 'en';

  void setLan(String value) {
    lan = value;
    notifyListeners();
  }

  bool get darkMode => _darkMode;

  void toggleDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }
}
