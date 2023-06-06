import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ozay_restaurant_app/core/Menu/model/order_model.dart';
import 'package:ozay_restaurant_app/view/home_page.dart';

import '../auth.dart';
import '../core/Menu/model/cart_model.dart';
import '../core/User/bloc/user_bloc.dart';

class PaymentPage extends StatelessWidget {
  PaymentPage({super.key, required this.totalPrice});
  final int totalPrice;
  TextEditingController _tableNumberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
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
        title: Text("PAYMENT"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: readCart(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something went wrong"));
          } else if (snapshot.hasData) {
            final cart = snapshot.data;
            //final cart = snapshot.data;
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                                " Please fill the card information and required fields",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _tableNumberController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(2),
                                  ],
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "Required"),
                                  ]),
                                  decoration: const InputDecoration(
                                    labelText: "Table Number",
                                    hintText: "Table Number",
                                    border: OutlineInputBorder(),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: const Icon(Icons.table_chart),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: TextFormField(
                                    controller: _descriptionController,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required"),
                                    ]),
                                    decoration: const InputDecoration(
                                      labelText: "Description",
                                      hintText: "Description",
                                      border: OutlineInputBorder(),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: const Icon(Icons.description),
                                      ),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _cardNumberController,
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "Required"),
                                  ]),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(19),
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: "Card Number",
                                    hintText: "Card Number",
                                    border: OutlineInputBorder(),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: const Icon(Icons.credit_card),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: TextFormField(
                                    controller: _nameController,
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: "Required"),
                                    ]),
                                    decoration: const InputDecoration(
                                      labelText: "Name",
                                      hintText: "Name",
                                      border: OutlineInputBorder(),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: const Icon(Icons.person),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _cvvController,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Required"),
                                        ]),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(3),
                                        ],
                                        decoration: const InputDecoration(
                                          labelText: "CVV",
                                          hintText: "CVV",
                                          border: OutlineInputBorder(),
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Icon(Icons.credit_card),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: TextFormField(
                                        controller: _expiryDateController,
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Required"),
                                          MinLengthValidator(5,
                                              errorText: "Invalid Date"),
                                        ]),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        decoration: const InputDecoration(
                                          labelText: "MM/YY",
                                          hintText: "MM/YY",
                                          border: OutlineInputBorder(),
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Icon(Icons.calendar_month),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: ElevatedButton(
                              onPressed: () {
                                final orderTableNumber =
                                    int.parse(_tableNumberController.text);
                                final OrderModel orderModel = OrderModel(
                                  tableNumber: orderTableNumber,
                                  description: _descriptionController.text,
                                  name: state.user!.name,
                                  surname: state.user!.surname,
                                  email: state.user!.email,
                                  phone: state.user!.phone,
                                  id: DateTime.now().toString(),
                                  totalPrice: totalPrice,
                                  cart: cart!,
                                );
                                final order = orderModel.toFirestore();
                                FirebaseFirestore.instance
                                    .collection("Orders")
                                    .doc()
                                    .set(order);
                                for (var i = 0; i < cart.length; i++) {
                                  FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(user!.uid)
                                      .collection('Cart')
                                      .doc(cart[i].id)
                                      .delete();
                                }
                                const Duration(seconds: 1);
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Payment Successful!",
                                  onConfirmBtnTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                              child: const Text("Pay"),
                              style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).colorScheme.tertiary,
                                //padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                textStyle: const TextStyle(fontSize: 20),
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
