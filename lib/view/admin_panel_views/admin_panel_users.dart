import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/core/User/model/user_model.dart';

class AdminPanelUsers extends StatelessWidget {
  const AdminPanelUsers({super.key});
  static const routeName = '/adminPanelUsers';

  @override
  Widget build(BuildContext context) {
    Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
        .collection("Users")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => UserModel.fromFirestore(document.data()))
            .toList());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text("Admin Panel Users"),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: users!.map(
                (e) {
                  return _buildUserListTile(e, context);
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

Widget _buildUserListTile(UserModel userModel, BuildContext context) {
  return ListTile(
    leading: Icon(
      Icons.person,
      size: 40,
      color: Theme.of(context).colorScheme.secondary,
    ),
    title: Text("${userModel.name}${userModel.surname}"),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${userModel.email}"),
        Text("${userModel.phone}"),
      ],
    ),
    trailing: IconButton(
      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.tertiary),
      onPressed: () async {
        FirebaseFirestore.instance
            .collection("Users")
            .doc(userModel.uId)
            .delete();
      },
    ),
  );
}
