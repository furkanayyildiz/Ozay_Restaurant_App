import 'package:flutter/material.dart';

import '../../view/login_view.dart';

class PopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;

  const PopAppBar({
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      leadingWidth: 10,
      titleSpacing: 5,
      title: title == null
          ? Center(
              child: AspectRatio(
                aspectRatio: 2,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            )
          : title,
      actions: actions,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      elevation: 4,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}
