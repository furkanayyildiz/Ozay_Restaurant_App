import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:ozay_restaurant_app/core/HomePage/campaigns_model.dart';
import 'package:ozay_restaurant_app/core/User/bloc/user_bloc.dart';
import 'package:ozay_restaurant_app/products/components/custom_textfield.dart';
import 'package:ozay_restaurant_app/view/login_view.dart';
import 'package:intl/intl.dart';
import '../products/components/custom_elevated_button.dart';

class OpinionsPage extends StatelessWidget {
  OpinionsPage({super.key});

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text("Opinions"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.isUserLoggedIn == false) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Please login to see your opinion form",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                        );
                      },
                      child: Text("Login"))
                ],
              ),
            );
          }
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Please write your opinions about our restaurant",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: CustomTextField(
                    controller: _titleController,
                    height: context.height * 0.07,
                    width: context.width * 0.8,
                    hinttext: "Title",
                    prefixIcon: Icon(
                      Icons.title,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: CustomTextField(
                    controller: _descriptionController,
                    height: context.height * 0.07,
                    width: context.width * 0.8,
                    hinttext: "Description",
                    prefixIcon: Icon(
                      Icons.description,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomElevatedButton(
                    onPressed: () {
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(now);
                      FirebaseFirestore.instance
                          .collection('Opinions')
                          .doc(formattedDate)
                          .set({
                        "id": formattedDate,
                        "name": state.user!.name,
                        "surname": state.user!.surname,
                        "email": state.user!.email,
                        "phone": state.user!.phone,
                        'title': _titleController.text,
                        'description': _descriptionController.text,
                      });
                      Navigator.pop(context);
                    },
                    borderRadius: 20,
                    color: Theme.of(context).colorScheme.primary,
                    height: context.height * 0.07,
                    width: context.width * 0.6,
                    child: Text(
                      "SEND",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ]);
        },
      ),
    );
  }
}
