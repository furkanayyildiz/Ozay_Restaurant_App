import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozay_restaurant_app/view/home_page.dart';

import '../core/User/bloc/user_bloc.dart';

class AdminControlPanelPage extends StatelessWidget {
  const AdminControlPanelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Admin Control Panel"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 4,
          ),
          body: Center(
              child: ElevatedButton(
                  onPressed: () {
                    context.read<UserBloc>().add(LogoutEvent());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: Text("Logout"))),
        );
      },
    );
  }
}
