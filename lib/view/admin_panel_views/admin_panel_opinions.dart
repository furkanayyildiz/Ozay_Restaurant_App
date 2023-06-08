import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ozay_restaurant_app/core/HomePage/opinion_model.dart';
import 'package:ozay_restaurant_app/init_page.dart';

class AdminPanelOpinions extends StatelessWidget {
  const AdminPanelOpinions({super.key});
  static const routeName = '/adminPanelOpinions';

  @override
  Widget build(BuildContext context) {
    Stream<List<OpinionModel>> readOrdersList() => FirebaseFirestore.instance
        .collection('Opinions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => OpinionModel.fromFirestore(document.data()))
            .toList());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text("Admin Panel Opinions"),
      ),
      body: StreamBuilder<List<OpinionModel>>(
        stream: readOrdersList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          } else if (snapshot.hasData) {
            final opinions = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: opinions!.map(
                (e) {
                  return _buildOpinionListTile(e, context);
                },
              ).toList(),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("There is no opinion"),
            );
          } else {
            return const Center(
              child: Text("There is no opinion"),
            );
          }
        },
      ),
    );
  }

  Widget _buildOpinionListTile(OpinionModel e, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(e.title),
        subtitle: Text(e.description),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('Opinions')
                .doc(e.id)
                .delete();
          },
        ),
      ),
    );
  }
}
