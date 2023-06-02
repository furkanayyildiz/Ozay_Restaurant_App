import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_panel_products_list.dart';

import '../../core/Menu/model/category_model.dart';

class AdminPanelProductsCategories extends StatelessWidget {
  const AdminPanelProductsCategories({super.key});
  static const routeName = '/adminPanelProductsCategories';

  @override
  Widget build(BuildContext context) {
    Stream<List<CategoryModel>> readCategories() => FirebaseFirestore.instance
        .collection("Categories")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => CategoryModel.fromFirestore(document.data()))
            .toList());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text("Admin Panel Porudcts"),
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: readCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          } else if (snapshot.hasData) {
            final categories = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: categories!.map(
                (e) {
                  return _buildCategoriesListTile(e, context);
                },
              ).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Widget _buildCategoriesListTile(
    CategoryModel categoryModel, BuildContext context) {
  return ListTile(
    leading: Image.network(categoryModel.imageLink, width: 50, height: 50),
    title: Text("${categoryModel.name}"),
    trailing: IconButton(
      icon: Icon(
        Icons.arrow_forward,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      onPressed: () async {
        Navigator.of(context).pushNamed(
          AdminPanelProductsList.routeName,
          arguments: categoryModel.name,
        );
      },
    ),
  );
}
