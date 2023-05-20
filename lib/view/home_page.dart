import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/products/widget/carousel_slider/carousel_card.dart';
import 'package:ozay_restaurant_app/products/widget/carousel_slider/category_model.dart';
import '../products/widget/bottom_bar.dart';
import '../products/widget/pop_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import '../products/widget/drawer/advanced_drawer.dart';
import '../products/widget/drawer/drawer_content.dart';
import './login_view.dart';
import "package:firebase_auth/firebase_auth.dart";
import '../auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  final User? user = Auth().currentUser;

  Future<void> _signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawerWidget(
      controller: _advancedDrawerController,
      drawer: const DrawerContent(),
      child: Scaffold(
        //extendBodyBehindAppBar: true,
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
          actions: [ElevatedButton(onPressed: _signOut, child: Text("Logout"))],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user?.email ?? "No User"),
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GridTile(
                        child: GestureDetector(
                          onTap: () {},
                          child: Image.network(
                            "https://www.tokattadimdoner.com/image/cache/catalog/urunler/kuru_menu-750x750.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        footer: GridTileBar(
                          backgroundColor: Colors.black87,
                          leading: IconButton(
                            icon: Icon(
                              Icons.favorite,
                            ),
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {},
                          ),
                          //child: Text(" Eğer buraya değişmesini istemediğimiz bir widget gelseydi child ile bunu yapardık "),

                          title: Text(
                            "kuru piav menüsü",
                            textAlign: TextAlign.center,
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
        bottomNavigationBar: const BottomBar(),
      ),
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}
