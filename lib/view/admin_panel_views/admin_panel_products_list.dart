import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/core/Menu/model/meal_model.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_panel_product_add.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_panel_product_edit.dart';

class AdminPanelProductsList extends StatelessWidget {
  const AdminPanelProductsList({super.key});
  static const routeName = '/adminPanelProductsList';

  @override
  Widget build(BuildContext context) {
    final String categoryName =
        ModalRoute.of(context)!.settings.arguments as String;
    Stream<List<MealModel>> readMeals() => FirebaseFirestore.instance
        .collection(categoryName)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => MealModel.fromFirestore(document.data()))
            .toList());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text("Admin Panel Products"),
      ),
      body: StreamBuilder<List<MealModel>>(
        stream: readMeals(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          } else if (snapshot.hasData) {
            final meals = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: meals!.map(
                (e) {
                  return _builMealsListTile(e, context);
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
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          splashColor: Colors.white,
          onPressed: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => AdminPanelProductAdd(
                categoryName: categoryName,
              ),
            );
            Navigator.push(context, route);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

Widget _builMealsListTile(MealModel mealModel, BuildContext context) {
  return ListTile(
    leading: Image.network(mealModel.imageLink, width: 65, height: 65),
    title: Text("${mealModel.name}"),
    trailing: Container(
      width: 100,
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () async {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) =>
                    AdminPanelProductEdit(mealModel: mealModel),
              );
              Navigator.push(context, route);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            onPressed: () async {
              FirebaseFirestore.instance
                  .collection(mealModel.category)
                  .doc(mealModel.name)
                  .delete();
            },
          ),
        ],
      ),
    ),
  );
}
