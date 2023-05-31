import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_control_panel_page.dart';
import 'package:ozay_restaurant_app/view/home_page.dart';
import './auth.dart';
import './view/login_view.dart';
import './view/register_view.dart';
import './core/User/bloc/user_bloc.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return StreamBuilder(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.email == "admin@gmail.com") {
                //context.read<UserBloc>().add(IsUserLoggedIn());
                return const AdminPanelPage();
              } else {
                context.read<UserBloc>().add(IsUserLoggedIn());
                return const HomePage();
              }
            } else {
              return const HomePage();
            }
          },
        );
      },
    );
  }
}
