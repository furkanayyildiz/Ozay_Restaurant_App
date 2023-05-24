part of 'user_bloc.dart';

enum UserStatus {
  inital,
  loggedIn,
  loggedOut,
  error,
}

enum LoginStatus {
  inital,
  loggingIn,
  loggedIn,
  loginError,
}

enum RegisterStatus {
  inital,
  registering,
  registered,
  registerError,
}

enum LogoutStatus {
  inital,
  loggingOut,
  loggedOut,
  logoutError,
}

class UserState extends Equatable {
  final bool isUserLoggedIn;
  final bool isUserAdmin;
  final User? user;
  final String? loginErrorMessage;
  final LoginStatus loginStatus;
  final RegisterStatus registerStatus;
  final LogoutStatus logoutStatus;
  final UserStatus userStatus;
  const UserState({
    this.isUserLoggedIn = false,
    this.user,
    this.loginErrorMessage,
    this.loginStatus = LoginStatus.inital,
    this.isUserAdmin = false,
    this.registerStatus = RegisterStatus.inital,
    this.logoutStatus = LogoutStatus.inital,
    this.userStatus = UserStatus.inital,
  });

  @override
  List<Object?> get props => [
        isUserLoggedIn,
        user,
        loginErrorMessage,
        loginStatus,
        isUserAdmin,
        registerStatus,
        logoutStatus,
        userStatus,
      ];

  UserState copyWith({
    bool? isUserLoggedIn,
    User? user,
    String? loginErrorMessage,
    LoginStatus? loginStatus,
    bool? isUserAdmin,
    RegisterStatus? registerStatus,
    LogoutStatus? logoutStatus,
    UserStatus? userStatus,
  }) {
    return UserState(
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
      user: user ?? this.user,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
      loginStatus: loginStatus ?? this.loginStatus,
      isUserAdmin: isUserAdmin ?? this.isUserAdmin,
      registerStatus: registerStatus ?? this.registerStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      userStatus: userStatus ?? this.userStatus,
    );
  }
}
