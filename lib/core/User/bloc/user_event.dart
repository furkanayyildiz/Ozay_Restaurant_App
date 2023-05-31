part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class IsUserLoggedIn extends UserEvent {
  //final User user;
  const IsUserLoggedIn();

  @override
  List<Object> get props => [];
}

class LoginEvent extends UserEvent {
  final String email;
  final String password;
  final BuildContext context;
  const LoginEvent(
      {required this.email, required this.password, required this.context});

  @override
  List<Object> get props => [email, password, context];
}

class RegisterEvent extends UserEvent {
  final String name;
  final String surname;
  final String email;
  final String phone;
  final String password;
  const RegisterEvent({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object> get props => [
        name,
        surname,
        email,
        phone,
        password,
      ];
}

class LogoutEvent extends UserEvent {
  final BuildContext context;
  const LogoutEvent({required this.context});

  @override
  List<Object> get props => [context];
}
