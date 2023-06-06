import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ozay_restaurant_app/auth.dart';
import 'package:ozay_restaurant_app/core/Menu/model/cart_model.dart';
import 'package:ozay_restaurant_app/view/home_page.dart';
import 'package:ozay_restaurant_app/view/menu/menu_page.dart';
import 'package:ozay_restaurant_app/view/payment_page.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  static const routeName = '/cart';
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    Stream<List<CartModel>> readCart() => FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('Cart')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => CartModel.fromFirestore(document.data()))
            .toList());
    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(
                LineAwesomeIcons.arrow_left,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Text("CART"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.confirm,
                  text: "Are you sure you want to clear the cart?",
                  confirmBtnText: "Yes",
                  cancelBtnText: "No",
                  onConfirmBtnTap: () {
                    FirebaseFirestore.instance
                        .collection('Users')
                        .doc(user!.uid)
                        .collection('Cart')
                        .get()
                        .then((snapshot) {
                      for (DocumentSnapshot ds in snapshot.docs) {
                        ds.reference.delete();
                      }
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                );
              },
              icon: Icon(LineAwesomeIcons.trash),
            ),
          ],
        ),
        body: StreamBuilder<List<CartModel>>(
          stream: readCart(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong ${snapshot.error}');
            } else if (!snapshot.hasData) {
              print(!snapshot.hasData);
              return Center(
                child: Text("Cart is empty",
                    style: TextStyle(fontSize: 20, color: Colors.red)),
              );
            } else if (snapshot.hasData) {
              final cart = snapshot.data;
              int total = 0;
              for (var i = 0; i < cart!.length; i++) {
                final itemTotal = cart[i].price * cart[i].quantity;
                total = total + itemTotal;
              }
              print(total);
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: ListView(
                      padding: EdgeInsets.all(10),
                      children: cart.map(
                        (cartModel) {
                          return buildCartCard(cartModel, context);
                        },
                      ).toList(),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: SizedBox(
                          child: Container(
                            color: Colors.grey[200],
                            width: MediaQuery.of(context).size.width * 0.8,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Text("Total Price:",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    Text(
                                      "$total ₺",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PaymentPage(
                                                totalPrice: total,
                                              )),
                                    );
                                  },
                                  label: Text("Pay Now"),
                                  icon: Icon(Icons.arrow_forward, size: 20),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(150, 50),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

Widget buildCartCard(CartModel cartModel, BuildContext context) => Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: Colors.grey[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(child: Image.network(cartModel.imageLink)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartModel.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      "${cartModel.price.toString()}₺",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      if (cartModel.quantity > 1) {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('Cart')
                            .doc(cartModel.id)
                            .update({'quantity': cartModel.quantity - 1});
                      } else {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection('Cart')
                            .doc(cartModel.id)
                            .delete();
                      }
                    },
                  ),
                  Text(cartModel.quantity.toString()),
                  IconButton(
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('Cart')
                          .doc(cartModel.id)
                          .update({'quantity': cartModel.quantity + 1});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
