import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/products/widget/carousel_slider/carousel_card.dart';
import 'package:ozay_restaurant_app/products/widget/carousel_slider/category_model.dart';
import '../products/widget/bottom_bar.dart';
import '../products/widget/pop_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../products/widget/drawer/advanced_drawer.dart';
import '../products/widget/drawer/drawer_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawerWidget(
      controller: _advancedDrawerController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Advanced Drawer Example'),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.0,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  initialPage: 2,
                  autoPlay: true,
                ),
                items: Category.categories
                    .map((category) => CarouselCard(category: category))
                    .toList(),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomBar(),
      ),
      drawer: const DrawerContent(),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
