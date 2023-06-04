import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:kartal/kartal.dart';
import 'package:ozay_restaurant_app/core/Menu/model/meal_model.dart';
import 'package:ozay_restaurant_app/core/User/model/user_model.dart';
import 'package:ozay_restaurant_app/products/components/custom_textfield.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({
    super.key,
    required this.user,
  });
  final UserModel? user;

  @override
  State<ProfileEditPage> createState() => _ProfileEditPage();
}

class _ProfileEditPage extends State<ProfileEditPage> {
  TextEditingController? nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController!.text = widget.user!.name;
    surnameController.text = widget.user!.surname;
    emailController.text = widget.user!.email;
    phoneController.text = widget.user!.phone;

    super.initState();
  }

  void dispose() {
    nameController!.dispose();
    surnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<UserModel> readUser() async {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromFirestore(data);
      return user;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        title: const Text("Profile Edit Page"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<UserModel>(
                future: readUser(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data;
                    return user == null
                        ? Center(
                            child: Text("No User"),
                          )
                        : SizedBox(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, top: 5),
                                    child: const Text(
                                      "Edit Your Information",
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
                                      height: context.height * 0.08,
                                      width: context.width * 0.8,
                                      controller: nameController),
                                  context.emptySizedHeightBoxLow,
                                  CustomTextField(
                                    hinttext: "Surname",
                                    labelText: "Surname",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Surname is required'),
                                    ]),
                                    readOnly: false,
                                    height: context.height * 0.07,
                                    width: context.width * 0.8,
                                    controller: surnameController,
                                  ),
                                  context.emptySizedHeightBoxLow,
                                  CustomTextField(
                                    hinttext: "Email",
                                    labelText: "Email",
                                    validator: MultiValidator([
                                      EmailValidator(
                                          errorText: 'Enter a valid email'),
                                      RequiredValidator(
                                          errorText: 'Email is required'),
                                      MinLengthValidator(10,
                                          errorText:
                                              'Email should be at least 10 digits long'),
                                    ]),
                                    readOnly: true,
                                    height: context.height * 0.07,
                                    width: context.width * 0.8,
                                    controller: emailController,
                                  ),
                                  context.emptySizedHeightBoxLow,
                                  CustomTextField(
                                    hinttext: "Phone Number",
                                    labelText: "Phone Number",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              'Phone Number is required'),
                                      MinLengthValidator(10,
                                          errorText:
                                              'Phone Number should be at least 10 digits long'),
                                    ]),
                                    readOnly: false,
                                    height: context.height * 0.07,
                                    width: context.width * 0.8,
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                  ),
                                  context.emptySizedHeightBoxLow,
                                  CustomTextField(
                                    hinttext: "Password",
                                    labelText: "Password",
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText:
                                              'Enter Your Current Password or New One'),
                                      MinLengthValidator(8,
                                          errorText:
                                              'Password should be at least 10 digits long'),
                                    ]),
                                    readOnly: false,
                                    height: context.height * 0.07,
                                    width: context.width * 0.8,
                                    controller: passwordController,
                                  ),
                                  context.emptySizedHeightBoxLow3x,
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        FirebaseAuth.instance.currentUser!
                                            .updatePassword(
                                                passwordController.text);
                                        FirebaseAuth.instance.currentUser!
                                            .updateEmail(emailController.text);
                                        FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          "name": nameController!.text,
                                          "surname": surnameController.text,
                                          "email": emailController.text,
                                          "phone": phoneController.text,
                                        });
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.success,
                                          text: "Profile Updated",
                                          onConfirmBtnTap: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            content: Text(
                                                "Please fill in the required fields"),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text("Edit Profile"),
                                  ),
                                ],
                              ),
                            ),
                          );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
  }
}
