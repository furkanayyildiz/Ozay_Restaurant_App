import 'package:flutter/material.dart';

import '../../view/login_view.dart';

class PopAppbar extends StatelessWidget with PreferredSizeWidget {
  final Size appBarHeight;
  final Widget? actions;
  final void Function()? onPop;

  const PopAppbar({
    Key? key,
    this.appBarHeight = const Size.fromHeight(70),
    this.actions,
    this.onPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const AspectRatio(
        aspectRatio: 4,
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [
        //if (actions != null) actions!
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
            child: Text("Login"))
      ],
      leadingWidth: 60,
      toolbarHeight: appBarHeight.height,
      backgroundColor: Colors.red,
      elevation: 4,
    );
  }

  @override
  Size get preferredSize => appBarHeight;
}
