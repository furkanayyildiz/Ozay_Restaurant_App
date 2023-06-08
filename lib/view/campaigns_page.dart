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
      body: StreamBuilder<List<CampaignsModel>>(
        stream: readCampaigns(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          } else if (snapshot.hasData) {
            final campaigns = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: campaigns!.map(
                (e) {
                  return _buildCampaignsListTile(e, context);
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

  Widget _buildCampaignsListTile(CampaignsModel e, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(e.title),
        subtitle: Text(e.description),
      ),
    );
  }
}
