//Import
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozay_restaurant_app/core/User/bloc/user_bloc.dart';
import 'package:ozay_restaurant_app/products/widget/profile/constants.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_panel_categories.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_panel_products.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_panel_products_list.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_panel_users.dart';
import 'package:ozay_restaurant_app/view/contact_page.dart';
import 'package:ozay_restaurant_app/view/login_view.dart';
import 'package:ozay_restaurant_app/view/menu/menu_page.dart';
import 'package:ozay_restaurant_app/widget_tree.dart';

// View
import './view/home_page.dart';
import 'view/profile_page.dart';
// Bloc
import 'package:ozay_restaurant_app/core/HomePage/bloc/home_page_bloc.dart';

//Export
export 'package:flutter/material.dart';
export 'package:bloc/bloc.dart';
//export 'package:flutter_native_splash/flutter_native_splash.dart';

part "init_page_helper.dart";

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> with InitPageHelper {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: ThemeProvider(
        initTheme: kLightTheme,
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'Ozay Restaurant App',
            themeMode: ThemeMode.system,
            theme: themeData,
            routes: routes,
            home: Scaffold(
              body: const WidgetTree(),
            ),
          );
        }),
      ),
    );
  }
}
