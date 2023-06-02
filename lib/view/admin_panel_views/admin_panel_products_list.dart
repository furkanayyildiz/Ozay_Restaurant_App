import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/core/Menu/model/meal_model.dart';

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
            onPressed: () async {},
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
