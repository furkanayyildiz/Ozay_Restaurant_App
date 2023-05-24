part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class IsUserLoggedIn extends UserEvent {
  final User user;
  const IsUserLoggedIn({required this.user});

  @override
  List<Object> get props => [user];
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
  final String email;
  final String password;
  const RegisterEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends UserEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}
