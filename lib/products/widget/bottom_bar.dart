import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      backgroundColor: Colors.red,
      initialActiveIndex: 2,
      shadowColor: Colors.black38,
      cornerRadius: 15,
      items: const [
        TabItem(title: "Home", icon: Icons.home),
        TabItem(title: "Menu", icon: Icons.menu_book),
        TabItem(title: "Sepet", icon: Icons.shopping_cart),
        TabItem(title: "Contact", icon: Icons.phone_in_talk_outlined),
        TabItem(title: "Profile", icon: Icons.person),
      ],
      onTap: (int i) => print('click index=$i'),
    );
  }
}
