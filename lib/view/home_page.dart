import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozay_restaurant_app/core/Menu/model/meal_model.dart';
import 'package:ozay_restaurant_app/products/widget/carousel_slider/carousel_card.dart';
import 'package:ozay_restaurant_app/products/widget/carousel_slider/category_model.dart';
import '../core/User/bloc/user_bloc.dart';
import '../products/components/bottom_bar.dart';
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
    Stream<List<MealModel>> readFastMeals() => FirebaseFirestore.instance
        .collection('Fast Meals')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => MealModel.fromFirestore(document.data()))
            .toList());
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return AdvancedDrawerWidget(
          controller: _advancedDrawerController,
          drawer: const DrawerContent(),
          child: Scaffold(
            backgroundColor: Color(0xFFF5F5F3),
            //extendBodyBehindAppBar: true,
            //! popappbar olarak kendi barını koy ...
            appBar: AppBar(
              title: Center(
                child: AspectRatio(
                  aspectRatio: 3,
                  child: Image(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: IconButton(
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
              actions: [
                state.isUserLoggedIn == false
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                          );
                        },
                        child: Text("Login"))
                    : ElevatedButton(
                        onPressed: () {
                          context
                              .read<UserBloc>()
                              .add(LogoutEvent(context: context));
                        },
                        child: Text("Logout"),
                      ),
              ],
            ),
            body: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "FAST MEALS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: StreamBuilder<List<MealModel>>(
                        stream: readFastMeals(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            print("###################### ${snapshot.error}");
                            return const Text('Something went wrong');
                          } else if (snapshot.hasData) {
                            final meals = snapshot.data!;
                            return GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: meals.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 200,
                                  height: 265,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 3,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.network(
                                                meals[index].imageLink,
                                                height: 150,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          meals[index].name,
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          meals[index].description,
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${meals[index].price.toString()} TL",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.add_circle_outline),
                                              color: Colors.red,
                                              iconSize: 28,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            bottomNavigationBar: const BottomBar(),
          ),
        );
      },
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }

  Widget buildFastMealCard(BuildContext context, MealModel mealModel) =>
      GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            height: 265,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          mealModel.imageLink,
                          height: 150,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    mealModel.name,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    mealModel.description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${mealModel.price.toString()} TL",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_circle_outline),
                        color: Colors.red,
                        iconSize: 28,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );
}
