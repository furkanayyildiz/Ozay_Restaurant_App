import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import '../core/User/bloc/user_bloc.dart';
import '../products/components/app_text.dart';
import "../products/components/custom_textfield.dart";
import "../products/components/custom_elevated_button.dart";
import 'login_view.dart';
import "package:firebase_auth/firebase_auth.dart";
import '../auth.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String errorMessage = "";
  //bool isLogin = true;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth()
          .createUserWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          )
          .then((value) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              ));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message!;
      });
    }
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == "" ? "" : errorMessage,
      style: TextStyle(color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return _body(context, state);
        },
      ),
    );
  }

  SizedBox _body(BuildContext context, UserState state) {
    return SizedBox(
      height: context.height * 1,
      width: context.width * 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            context.emptySizedHeightBoxLow3x,
            topImage(context),
            context.emptySizedHeightBoxLow3x,
            topText(context),
            context.emptySizedHeightBoxLow3x,
            CustomTextField(
              controller: _nameController,
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.firstName,
              prefixIcon: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            context.emptySizedHeightBoxLow,
            CustomTextField(
              controller: _surnameController,
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.lastName,
              prefixIcon: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            context.emptySizedHeightBoxLow,
            CustomTextField(
              controller: _emailController,
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.email,
              prefixIcon: Icon(
                Icons.email,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            context.emptySizedHeightBoxLow,
            CustomTextField(
              controller: _phoneController,
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.phone,
              prefixIcon: Icon(
                Icons.phone,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            context.emptySizedHeightBoxLow,
            CustomTextField(
              controller: _passwordController,
              height: context.height * 0.07,
              width: context.width * 0.8,
              hinttext: AppText.password,
              prefixIcon: Icon(
                Icons.lock,
                color: Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: const Icon(Icons.remove_red_eye),
            ),
            context.emptySizedHeightBoxLow3x,
            CustomElevatedButton(
              onPressed: () async {
                context.read<UserBloc>().add(RegisterEvent(
                      name: _nameController.text,
                      surname: _surnameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      password: _passwordController.text,
                    ));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                );
              },
              borderRadius: 20,
              color: Theme.of(context).colorScheme.primary,
              height: context.height * 0.07,
              width: context.width * 0.6,
              child: Text(
                AppText.signUp.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            bottomText(context),
            context.emptySizedHeightBoxLow3x,
            _errorMessage(),
          ],
        ),
      ),
    );
  }

  SizedBox topImage(BuildContext context) {
    return SizedBox(
      height: context.height * 0.2,
      child: Image.asset('assets/images/logo.png'),
    );
  }

  Text topText(BuildContext context) {
    return Text(
      AppText.signUp.toUpperCase(),
      style: context.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  SizedBox bottomText(BuildContext context) {
    return SizedBox(
      width: context.width * 0.7,
      height: context.height * 0.08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            AppText.already,
          ),
          TextButton(
            child: Text(
              AppText.login,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
          )
        ],
      ),
    );
  }
}
