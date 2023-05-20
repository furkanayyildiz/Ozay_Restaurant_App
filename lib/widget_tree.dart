import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:ozay_restaurant_app/view/home_page.dart';
import './auth.dart';
import './view/login_view.dart';
import './view/register_view.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
