import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/core/Menu/model/cart_model.dart';
import 'package:ozay_restaurant_app/core/Menu/model/order_model.dart';
import 'package:ozay_restaurant_app/view/admin_panel_views/admin_panel_order_detail.dart';

class AdminPanelOrders extends StatelessWidget {
  const AdminPanelOrders({super.key});
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    Stream<List<OrderModel>> readOrdersList() => FirebaseFirestore.instance
        .collection('Orders')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => OrderModel.fromFirestore(document.data()))
            .toList());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text("Admin Panel Orders"),
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: readOrdersList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          } else if (snapshot.hasData) {
            final orders = snapshot.data;
            return ListView(
              padding: const EdgeInsets.all(16),
              children: orders!.map(
                (e) {
                  return _buildOrderListTile(e, context);
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

  Widget _buildOrderListTile(OrderModel orderModel, BuildContext context) =>
      ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Text(
            "${orderModel.tableNumber}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          "${orderModel.name}${orderModel.surname}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${orderModel.email}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AdminPanelOrderDetail(
                id: orderModel.id,
                name: orderModel.name,
                surname: orderModel.surname,
                email: orderModel.email,
                phone: orderModel.phone,
                tableNumber: orderModel.tableNumber,
                description: orderModel.description,
                totalPrice: orderModel.totalPrice,
              );
            }));
          },
        ),
      );
}
