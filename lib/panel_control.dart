import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_control_panel_page.dart';
import 'package:ozay_restaurant_app/view/home_page.dart';
import './auth.dart';
import './view/login_view.dart';
import './view/register_view.dart';
import './core/User/bloc/user_bloc.dart';

class PanelControl extends StatefulWidget {
  const PanelControl({super.key});

  @override
  State<PanelControl> createState() => _PanelControlState();
}

class _PanelControlState extends State<PanelControl> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.data!.email == "admin@gmail.com") {
            return const AdminControlPanelPage();
          } else {
            return const HomePage();
          }
        });
  }
}
