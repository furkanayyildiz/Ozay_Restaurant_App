import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:ozay_restaurant_app/init_page.dart';
import "../../../auth.dart";
import '../../../view/admin_panel_views/admin_control_panel_page.dart';
import '../../../view/home_page.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<IsUserLoggedIn>(_isUserLoggedIn);
    on<LoginEvent>(_loginEvent);
    on<RegisterEvent>(_registerEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  FutureOr<void> _isUserLoggedIn(
      IsUserLoggedIn event, Emitter<UserState> emit) {
    emit(state.copyWith(isUserLoggedIn: true, user: event.user));
  }

  void _loginEvent(LoginEvent event, Emitter<UserState> emit) async {
    try {
      //emit(state.copyWith(loginStatus: LoginStatus.loggingIn));
      await Auth().signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      var user = Auth().currentUser;

      if (user!.email! == "admin@gmail.com") {
        emit(state.copyWith(
          isUserLoggedIn: true,
          user: user,
          //loginStatus: LoginStatus.loggedIn,
          userStatus: UserStatus.loggedIn,
          isUserAdmin: true,
        ));
        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (context) => const AdminPanelPage()),
        );
      } else {
        emit(state.copyWith(
          isUserLoggedIn: true,
          user: user,
          //loginStatus: LoginStatus.loggedIn,
          userStatus: UserStatus.loggedIn,
          isUserAdmin: false,
        ));
        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.copyWith(
            loginErrorMessage: "No user found for that email.",
            //loginStatus: LoginStatus.loginError
            userStatus: UserStatus.error));
        print("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        emit(state.copyWith(
            loginErrorMessage: "Wrong password provided for that user.",
            //loginStatus: LoginStatus.loginError
            userStatus: UserStatus.error));
        print("Wrong password provided for that user.");
      } else {
        emit(state.copyWith(
            loginErrorMessage: "Something went wrong.",
            //loginStatus: LoginStatus.loginError
            userStatus: UserStatus.error));
      }
    }
  }

  FutureOr<void> _registerEvent(
      RegisterEvent event, Emitter<UserState> emit) async {
    try {
      emit(state.copyWith(registerStatus: RegisterStatus.registering));
      await Auth().createUserWithEmailAndPassword(
        event.email,
        event.password,
      );
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
    //emit(state.copyWith(logoutStatus: LogoutStatus.loggingOut));
    await Auth().signOut();

    emit(state.copyWith(
      isUserLoggedIn: false,
      user: null,
      isUserAdmin: null,
      logoutStatus: LogoutStatus.loggedOut,
      userStatus: UserStatus.loggedOut,
    ));
  }
}
