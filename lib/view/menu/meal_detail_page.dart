import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ozay_restaurant_app/core/Menu/model/cart_model.dart';
import 'package:ozay_restaurant_app/core/Menu/model/category_model.dart';
import 'package:ozay_restaurant_app/core/Menu/model/meal_model.dart';
import 'package:ozay_restaurant_app/view/login_view.dart';

import '../../core/User/bloc/user_bloc.dart';

class MealDetailPage extends StatelessWidget {
  final MealModel? mealModel;
  const MealDetailPage({super.key, required this.mealModel});

  @override
  Widget build(BuildContext context) {
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
        title: Text("Detail Page"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Image.network(
              mealModel!.imageLink,
              height: 300,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              mealModel!.name,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Price: ${mealModel!.price.toString()} ₺",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              mealModel!.description,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic),
            ),
          ),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // if(state.userModel!.cart!.contains(mealModel!.id)){
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text("This meal is already in your cart."),
                    //       duration: Duration(seconds: 2),
                    //     ),
                    //   );}
                    if (state.user == null) {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        title: "You must login to add cart.",
                        text: "Do you want to login?",
                        confirmBtnText: 'Yes',
                        cancelBtnText: 'No',
                        confirmBtnColor: Colors.green,
                        cancelBtnTextStyle: TextStyle(color: Colors.red),
                        onConfirmBtnTap: () {
                          Navigator.pushNamed(context, "/login");
                        },
                      );
                    } else {
                      final cartModel = CartModel(
                        name: mealModel!.name,
                        imageLink: mealModel!.imageLink,
                        price: mealModel!.price,
                        quantity: 1,
                        totalPrice: mealModel!.price,
                        id: mealModel!.id,
                        category: mealModel!.category,
                      );
                      final cartItem = cartModel.toFirestore();
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(state.user!.uId)
                          .collection("Cart")
                          .doc(mealModel!.id)
                          .set(cartItem);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Meal added to cart."),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.add_shopping_cart_outlined),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  label: const Text("Add to Cart"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
