import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ozay_restaurant_app/core/Menu/model/category_model.dart';
import 'package:ozay_restaurant_app/products/components/bottom_bar.dart';
import 'package:ozay_restaurant_app/products/components/pop_appbar.dart';
import 'package:ozay_restaurant_app/view/menu/category_meals_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});
  static const String routeName = "/menu";

  @override
  Widget build(BuildContext context) {
    Stream<List<CategoryModel>> readCategory() => FirebaseFirestore.instance
        .collection('Categories')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => CategoryModel.fromFirestore(document.data()))
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
      body: StreamBuilder<List<CategoryModel>>(
          stream: readCategory(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong ${snapshot.error}');
            } else if (snapshot.hasData) {
              final category = snapshot.data;
              return ListView(
                padding: EdgeInsets.all(16),
                children: category!.map(
                  (e) {
                    return buildImageCard(e, context);
                  },
                ).toList(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

Widget buildImageCard(CategoryModel categoryModel, BuildContext context) =>
    Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Ink.image(
            image: NetworkImage(
              categoryModel.imageLink.toString(),
            ),
            //colorFilter: ColorFilters.greyscale,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryMealsPage(
                            name: categoryModel.name.toString(),
                          )),
                );
              },
            ),
            height: 240,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              categoryModel.name.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
