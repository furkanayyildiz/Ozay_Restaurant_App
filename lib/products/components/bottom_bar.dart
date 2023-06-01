import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      backgroundColor: Theme.of(context).colorScheme.primary,
      initialActiveIndex: 2,
      shadowColor: Colors.black38,
      cornerRadius: 15,
      items: const [
        TabItem(title: "Home", icon: Icons.home),
        TabItem(title: "Menu", icon: Icons.menu_book),
        TabItem(title: "Cart", icon: Icons.shopping_cart),
        TabItem(title: "Contact", icon: Icons.phone_in_talk_outlined),
        TabItem(title: "Profile", icon: Icons.person),
      ],
      onTap: (int i) {
        switch (i) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/menu');
            break;
          case 2:
            Navigator.pushNamed(context, '/cart');
            break;
          case 3:
            Navigator.pushNamed(context, '/contact');
            break;
          case 4:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
