import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ozay_restaurant_app/core/Menu/model/cart_model.dart';

class AdminPanelOrderDetail extends StatelessWidget {
  const AdminPanelOrderDetail(
      {super.key,
      required this.id,
      required this.name,
      required this.surname,
      required this.email,
      required this.phone,
      required this.tableNumber,
      required this.description,
      required this.totalPrice});
  final String id;
  final String name;
  final String surname;
  final String email;
  final String phone;
  final int tableNumber;
  final String description;
  final int totalPrice;
  @override
  Widget build(BuildContext context) {
    Stream<List<CartModel>> readOrder() => FirebaseFirestore.instance
        .collection('Orders')
        .doc(id.toString())
        .collection('Products')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => CartModel.fromFirestore(document.data()))
            .toList());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text("Admin Panel Order Detail"),
      ),
      body: StreamBuilder<List<CartModel>>(
        stream: readOrder(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          } else if (snapshot.hasData) {
            final orders = snapshot.data;
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "ORDER OWNER INFORMATION",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      buildInfo("Name", name),
                      buildInfo("Surname", surname),
                      buildInfo("Email", email),
                      buildInfo("Phone", phone),
                      buildInfo("Table Number", tableNumber.toString()),
                      buildInfo("Description", description),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "ORDER INFORMATION",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView(
                          padding: const EdgeInsets.all(10),
                          children: orders!.map(
                            (e) {
                              return _buildOrderListTile(e, context);
                            },
                          ).toList(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Price: ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${totalPrice.toString()} TL",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
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

  Widget buildInfo(String property, String value) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            property + ": ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderListTile(CartModel cartModel, BuildContext context) {
    return ListTile(
      leading: Image.network(
        cartModel.imageLink,
        width: 70,
        height: 70,
      ),
      title: Text(
        cartModel.name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        "${cartModel.price.toString()} TL",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        "X ${cartModel.quantity}",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
