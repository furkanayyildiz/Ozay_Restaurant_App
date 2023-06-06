import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:ozay_restaurant_app/products/components/custom_textfield.dart';

class AdminPanelProductAdd extends StatefulWidget {
  const AdminPanelProductAdd({super.key, required this.categoryName});
  final String categoryName;
  @override
  State<AdminPanelProductAdd> createState() => _AdminPanelProductAddState();
}

class _AdminPanelProductAddState extends State<AdminPanelProductAdd> {
  TextEditingController? nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController imageLinkController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        title: const Text("Admin Panel New Product Add"),
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
                        "Add New Product",
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
                      height: context.height * 0.07,
                      width: context.width * 0.8,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Name is required'),
                      ]),
                      controller: nameController,
                    ),
                    context.emptySizedHeightBoxLow,
                    CustomTextField(
                      hinttext: "Price",
                      labelText: "Price",
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Price is required'),
                      ]),
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
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Description is required'),
                        MinLengthValidator(10,
                            errorText:
                                'Description should be at least 10 digits long'),
                      ]),
                      readOnly: false,
                      height: context.height * 0.10,
                      width: context.width * 0.8,
                      controller: descriptionController,
                    ),
                    context.emptySizedHeightBoxLow,
                    CustomTextField(
                      hinttext: "Image Link",
                      labelText: "Image Link",
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'Image Link is required'),
                      ]),
                      readOnly: false,
                      height: context.height * 0.10,
                      width: context.width * 0.8,
                      controller: imageLinkController,
                    ),
                    context.emptySizedHeightBoxLow3x,
                    if (nameController!.text.isNotEmpty)
                      ElevatedButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            final storageRef = FirebaseStorage.instance
                                .ref()
                                .child(nameController!.text);
                            await storageRef.putFile(File(image.path));
                            FirebaseStorage.instance
                                .ref()
                                .child(nameController!.text)
                                .getDownloadURL()
                                .then(
                              (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    imageLinkController.text = value;
                                  });
                                }
                              },
                            );
                          }
                        },
                        child: Text("Add photo"),
                      ),
                    context.emptySizedHeightBoxLow,
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final price = int.parse(priceController.text);
                          FirebaseFirestore.instance
                              .collection(widget.categoryName)
                              .doc(nameController!.text)
                              .set({
                            "id": nameController!.text,
                            "category": widget.categoryName,
                            "name": nameController!.text,
                            "price": price,
                            "description": descriptionController.text,
                            "imageLink": imageLinkController.text,
                          });
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.tertiary,
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
