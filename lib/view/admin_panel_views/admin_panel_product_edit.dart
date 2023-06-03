import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:ozay_restaurant_app/core/Menu/model/meal_model.dart';
import 'package:ozay_restaurant_app/products/components/custom_textfield.dart';

class AdminPanelProductEdit extends StatefulWidget {
  AdminPanelProductEdit({super.key, required this.mealModel});
  static const routeName = '/adminPanelProductEdit';
  MealModel mealModel;

  @override
  State<AdminPanelProductEdit> createState() => _AdminPanelProductEditState();
}

class _AdminPanelProductEditState extends State<AdminPanelProductEdit> {
  TextEditingController? nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController imageLinkController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController!.text = widget.mealModel.name;
    priceController.text = widget.mealModel.price.toString();
    descriptionController.text = widget.mealModel.description;
    imageLinkController.text = widget.mealModel.imageLink;

    super.initState();
  }

  void dispose() {
    nameController!.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text("Admin Panel Products"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 5),
                      child: const Text(
                        "Edit Product",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CustomTextField(
                      hinttext: "Name",
                      labelText: "Name",
                      readOnly: true,
                      height: context.height * 0.08,
                      width: context.width * 0.8,
                      controller: nameController,
                    ),
                    context.emptySizedHeightBoxLow,
                    CustomTextField(
                      hinttext: "Price",
                      labelText: "Price",
                      keyboardType: TextInputType.number,
                      readOnly: false,
                      height: context.height * 0.07,
                      width: context.width * 0.8,
                      controller: priceController,
                    ),
                    context.emptySizedHeightBoxLow,
                    CustomTextField(
                      hinttext: "Description",
                      labelText: "Description",
                      readOnly: false,
                      height: context.height * 0.07,
                      width: context.width * 0.8,
                      controller: descriptionController,
                    ),
                    context.emptySizedHeightBoxLow,
                    CustomTextField(
                      hinttext: "Image Link",
                      labelText: "Image Link",
                      readOnly: false,
                      height: context.height * 0.07,
                      width: context.width * 0.8,
                      controller: imageLinkController,
                    ),
                    context.emptySizedHeightBoxLow3x,
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final price = int.parse(priceController.text);
                          FirebaseFirestore.instance
                              .collection(widget.mealModel.category)
                              .doc(widget.mealModel.id)
                              .update({
                            "name": nameController!.text,
                            "price": price,
                            "description": descriptionController.text,
                            "imageLink": imageLinkController.text,
                          });
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Please fill in the required fields"),
                            ),
                          );
                        }
                      },
                      child: const Text("Edit Product"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
