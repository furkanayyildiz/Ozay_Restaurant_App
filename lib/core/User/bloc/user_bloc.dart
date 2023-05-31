import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:ozay_restaurant_app/core/User/model/user_model.dart';
import 'package:ozay_restaurant_app/init_page.dart';
import "../../../auth.dart";
import '../../../view/admin_panel_views/admin_control_panel_page.dart';
import '../../../view/home_page.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<LoginEvent>(_loginEvent);
    on<RegisterEvent>(_registerEvent);
    on<LogoutEvent>(_logoutEvent);
    on<IsUserLoggedIn>(_isUserLoggedIn);
  }

  FutureOr<void> _isUserLoggedIn(
      IsUserLoggedIn event, Emitter<UserState> emit) async {
    var user = Auth().currentUser;
    final docUser =
        FirebaseFirestore.instance.collection("Users").doc(user!.uid);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      var user = UserModel.fromFirestore(snapshot.data()!);
      emit(state.copyWith(isUserLoggedIn: true, user: user));
    }
  }

  void _loginEvent(LoginEvent event, Emitter<UserState> emit) async {
    try {
      await Auth().signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      var user = Auth().currentUser;

      if (user!.email! == "admin@gmail.com") {
        emit(state.copyWith(
          isUserLoggedIn: true,
          //user: user,
          userStatus: UserStatus.loggedIn,
          isUserAdmin: true,
        ));
        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (context) => const AdminPanelPage()),
        );
      } else {
        final docUser =
            FirebaseFirestore.instance.collection("Users").doc(user.uid);
        final snapshot = await docUser.get();
        if (snapshot.exists) {
          var user = UserModel.fromFirestore(snapshot.data()!);
          emit(state.copyWith(
            isUserLoggedIn: true,
            user: user,
            userStatus: UserStatus.loggedIn,
            isUserAdmin: false,
          ));
          print("####################" + user.phone);
        }

        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.copyWith(
            loginErrorMessage: "No user found for that email.",
            userStatus: UserStatus.error));
        print("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        emit(state.copyWith(
            loginErrorMessage: "Wrong password provided for that user.",
            userStatus: UserStatus.error));
        print("Wrong password provided for that user.");
      } else {
        emit(state.copyWith(
            loginErrorMessage: "Something went wrong.",
            userStatus: UserStatus.error));
      }
    }
  }

  FutureOr<void> _registerEvent(
      RegisterEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(registerStatus: RegisterStatus.registering));
      var user = await Auth().createUserWithEmailAndPassword(
        event.email,
        event.password,
      );
      final docUser =
          FirebaseFirestore.instance.collection("Users").doc(user.uid);
      final userModel = UserModel(
        name: event.name,
        surname: event.surname,
        email: event.email,
        phone: event.phone,
        uId: user.uid,
      );
      final toFirestoreUser = userModel.toFirestore();
      await docUser.set(toFirestoreUser);

      emit(state.copyWith(registerStatus: RegisterStatus.registered));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(state.copyWith(
          registerStatus: RegisterStatus.registerError,
          loginErrorMessage: "The password provided is too weak.",
        ));
        print("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        emit(state.copyWith(
          registerStatus: RegisterStatus.registerError,
          loginErrorMessage: "The account already exists for that email.",
        ));
        print("The account already exists for that email.");
      } else {
        emit(state.copyWith(
          registerStatus: RegisterStatus.registerError,
          loginErrorMessage: "Something went wrong.",
        ));
      }
    }
  }

  FutureOr<void> _logoutEvent(
      LogoutEvent event, Emitter<UserState> emit) async {
    await Auth().signOut();

    emit(state.copyWith(
      isUserLoggedIn: false,
      user: null,
      isUserAdmin: null,
      userStatus: UserStatus.loggedOut,
    ));
  }
}
