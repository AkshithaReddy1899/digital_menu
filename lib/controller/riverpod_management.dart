import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'cart_provider.dart';
import 'theme_provider.dart';


final themeRiverpod = ChangeNotifierProvider((ref) => ThemeProvider());

final cartRiverpod = ChangeNotifierProvider((ref) => CartProvider());
