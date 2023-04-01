import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/products/widget/carousel_slider/carousel_card.dart';
import 'package:ozay_restaurant_app/products/widget/carousel_slider/category_model.dart';
import '../products/widget/bottom_bar.dart';
import '../products/widget/pop_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PopAppbar(),
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
    );
  }
}
