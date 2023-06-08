import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/core/HomePage/campaigns_model.dart';

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<List<CampaignsModel>> readCampaigns() => FirebaseFirestore.instance
        .collection('Campaigns')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => CampaignsModel.fromFirestore(document.data()))
            .toList());
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 5,
          title: const Text("Campaigns"),
        ),
        body: Column(
          children: [
            _buildCampaignsListTile("2 Coffees & 1 Cake",
                "If those who come as a couple on the weekends buy 2 coffees, one of the selected cakes is a gift."),
            _buildCampaignsListTile("Burger %30 OFF",
                "30% discount on each burger if each group of friends between 18-24 years old of 4 or more buys a burger on Sundays. This discount is for one time only.")
          ],
        ));
  }

  Widget _buildCampaignsListTile(String title, String description) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(title),
          subtitle: Text(description),
        ),
      ),
    );
  }
}
