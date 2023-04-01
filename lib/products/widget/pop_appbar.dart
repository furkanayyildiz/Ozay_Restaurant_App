import 'package:flutter/material.dart';

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
      title: AspectRatio(
        aspectRatio: 4,
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      actions: [if (actions != null) actions!],
      leadingWidth: 60,
      toolbarHeight: appBarHeight.height,
      backgroundColor: Colors.red,
      elevation: 4,
    );
  }

  Size get preferredSize => appBarHeight;
}
