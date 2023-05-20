import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:ozay_restaurant_app/view/home_page.dart';
import '../products/components/app_text.dart';
import "../products/components/custom_textfield.dart";
import "../products/components/custom_elevated_button.dart";
import './register_view.dart';
import "package:firebase_auth/firebase_auth.dart";
import '../auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String errorMessage = "";
  bool isLogin = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth()
          .signInWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          )
          .then((value) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
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
      body: _body(context),
    );
  }

  SizedBox _body(BuildContext context) {
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
            midText(context),
            context.emptySizedHeightBoxLow,
            CustomElevatedButton(
              onPressed: signInWithEmailAndPassword,
              borderRadius: 20,
              color: Theme.of(context).colorScheme.primary,
              height: context.height * 0.07,
              width: context.width * 0.6,
              child: Text(
                AppText.login.toUpperCase(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            context.emptySizedHeightBoxLow3x,
            const Text(AppText.or),
            context.emptySizedHeightBoxLow3x,
            const Text(AppText.loginwith),
            context.emptySizedHeightBoxLow,
            socialIcon(context),
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
      AppText.login.toUpperCase(),
      style: context.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  SizedBox midText(BuildContext context) {
    return SizedBox(
      height: context.height * 0.1,
      width: context.width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Switch(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.white,
                activeTrackColor: Theme.of(context).colorScheme.primary,
              ),
              const Text(AppText.rememberMe),
            ],
          ),
          const Text(
            AppText.already,
          ),
        ],
      ),
    );
  }

  SizedBox socialIcon(BuildContext context) {
    return SizedBox(
      height: context.height * 0.1,
      width: context.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: null, icon: Image.asset('assets/images/google.png')),
          IconButton(
              onPressed: null, icon: Image.asset('assets/images/apple.png')),
          IconButton(
              onPressed: null, icon: Image.asset('assets/images/face.png')),
        ],
      ),
    );
  }

  SizedBox bottomText(BuildContext context) {
    return SizedBox(
      width: context.width * 0.7,
      height: context.height * 0.08,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppText.account,
          ),
          TextButton(
            child: Text(
              AppText.registernow,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterView()),
              );
            },
          )
        ],
      ),
    );
  }
}
