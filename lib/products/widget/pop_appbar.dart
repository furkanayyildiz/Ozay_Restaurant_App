import 'package:flutter/material.dart';

import '../../view/login_view.dart';

class PopAppbar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Widget? leading;

  const PopAppbar({
    this.title,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title == null
          ? Center(
              child: AspectRatio(
                aspectRatio: 3,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(title!),
            ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 4,
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 65);
}
