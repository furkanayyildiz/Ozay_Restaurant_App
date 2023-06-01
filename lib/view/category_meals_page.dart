import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ozay_restaurant_app/core/Menu/model/category_model.dart';
import 'package:ozay_restaurant_app/core/Menu/model/meal_model.dart';
import 'package:ozay_restaurant_app/products/components/bottom_bar.dart';
import 'package:ozay_restaurant_app/products/components/pop_appbar.dart';

class CategoryMealsPage extends StatelessWidget {
  final String name;
  const CategoryMealsPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    Stream<List<MealModel>> readCategoryMeal() => FirebaseFirestore.instance
        .collection(name)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => MealModel.fromFirestore(document.data()))
            .toList());
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
              LineAwesomeIcons.arrow_left,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text("MENU"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<MealModel>>(
          stream: readCategoryMeal(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong ${snapshot.error}');
            } else if (snapshot.hasData) {
              final categoryMeal = snapshot.data;
              return ListView(
                padding: EdgeInsets.all(16),
                children: categoryMeal!.map(
                  (e) {
                    return buildImageInteractionCard(e, context);
                  },
                ).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Widget buildImageInteractionCard(MealModel mealModel, BuildContext context) =>
      Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  mealModel.imageLink,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                // Positioned(
                //   bottom: 16,
                //   right: 16,
                //   left: 16,
                //   child: Text(
                //     'Cats rule the world!',
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       color: Colors.white,
                //       fontSize: 24,
                //     ),
                //   ),
                // ),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 14,
                  ),
                  child: Text(
                    mealModel.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                Text("${mealModel.price.toString()} ₺",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500)),
                TextButton(
                  child: const Text('View Details'),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      );
}
