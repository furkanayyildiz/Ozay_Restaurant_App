//Import
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// View
import './view/home_page.dart';
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
      child: MaterialApp(
        title: 'Ozay Restaurant App',
        themeMode: ThemeMode.system,
        theme: themeData,
        routes: routes,
        home: Scaffold(
          body: const HomePage(),
        ),
      ),
    );
  }
}
