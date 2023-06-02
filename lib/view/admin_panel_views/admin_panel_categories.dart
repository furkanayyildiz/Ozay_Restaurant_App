import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/core/Menu/model/category_model.dart';

class AdminPanelCategories extends StatelessWidget {
  const AdminPanelCategories({super.key});
  static const routeName = '/adminPanelCategories';

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
          title: const Text("Admin Panel Categories"),
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
        floatingActionButton: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            splashColor: Colors.white,
            onPressed: () {
              TextEditingController nameController = TextEditingController();
              TextEditingController imageLinkController =
                  TextEditingController();
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text("Add Category"),
                    content: SizedBox(
                      height: 130,
                      child: Column(
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              labelText: "Category Name",
                            ),
                          ),
                          TextField(
                            controller: imageLinkController,
                            decoration: const InputDecoration(
                              labelText: "Image Link",
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Categories")
                              .doc(nameController.text)
                              .set(
                            {
                              "name": nameController.text,
                              "imageLink": imageLinkController.text,
                            },
                          );
                          Navigator.pop(context);
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}

Widget _buildCategoriesListTile(
    CategoryModel categoryModel, BuildContext context) {
  return ListTile(
    leading: Image.network(categoryModel.imageLink, width: 50, height: 50),
    title: Text("${categoryModel.name}"),
    trailing: IconButton(
      icon: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      onPressed: () async {
        FirebaseFirestore.instance
            .collection("Categories")
            .doc(categoryModel.name)
            .delete();
      },
    ),
  );
}
