import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/User/bloc/user_bloc.dart';
import '../../../view/login_view.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  // Container(
                  //   width: 128.0,
                  //   height: 128.0,
                  //   margin: const EdgeInsets.only(
                  //     top: 24.0,
                  //     bottom: 64.0,
                  //   ),
                  //   clipBehavior: Clip.antiAlias,
                  //   decoration: BoxDecoration(
                  //     color: Colors.black26,
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: Image.asset(
                  //     'assets/images/logo.png',
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.percent_outlined),
                    title: Text('Campaigns'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.campaign_outlined),
                    title: Text('Announcement'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: Icon(Icons.message_outlined),
                    title: Text('Opinions'),
                  ),
                  state.user == null
                      ? ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          },
                          leading: Icon(Icons.login),
                          title: Text('Login'),
                        )
                      : ListTile(
                          onTap: () {
                            context
                                .read<UserBloc>()
                                .add(LogoutEvent(context: context));
                          },
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                        ),
                  Spacer(),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white54,
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 16.0,
                      ),
                      child: Text('Terms of Service | Privacy Policy'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
