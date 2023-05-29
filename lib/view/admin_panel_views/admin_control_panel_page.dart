import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozay_restaurant_app/products/widget/admin_panel_page_item.dart';
import 'package:ozay_restaurant_app/view/home_page.dart';

import '../../core/User/bloc/user_bloc.dart';
import '../../core/admin_panel_items_data.dart';
import '../../core/admin_panel_items_model.dart';

class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({super.key});

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
            actions: [
              ElevatedButton(
                  onPressed: () {
                    context.read<UserBloc>().add(LogoutEvent());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: Text("Logout")),
            ],
          ),
          body: GridView(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, //* width
              childAspectRatio: 3 / 2, //* heigt in width e oranı
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: adminPanelItems
                .map((data) => AdminPanelPageItem(data))
                .toList(),
          ),
          // Center(
          //     child: ElevatedButton(
          //         onPressed: () {
          //           context.read<UserBloc>().add(LogoutEvent());
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //                 builder: (context) => const HomePage()),
          //           );
          //         },
          //         child: Text("Logout"))),
        );
      },
    );
  }
}
