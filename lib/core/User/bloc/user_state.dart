part of 'user_bloc.dart';

enum UserStatus {
  inital,
  loggedIn,
  loggedOut,
  error,
}

enum RegisterStatus {
  inital,
  registering,
  registered,
  registerError,
}

class UserState extends Equatable {
  final bool isUserLoggedIn;
  //Todo alttaki bool u kaldır
  final bool isUserAdmin;
  final UserModel? user;
  final String? loginErrorMessage;
  final RegisterStatus registerStatus;

  final UserStatus userStatus;
  const UserState({
    this.isUserLoggedIn = false,
    this.user,
    this.loginErrorMessage,
    this.isUserAdmin = false,
    this.registerStatus = RegisterStatus.inital,
    this.userStatus = UserStatus.inital,
  });

  @override
  List<Object?> get props => [
        isUserLoggedIn,
        user,
        loginErrorMessage,
        isUserAdmin,
        registerStatus,
        userStatus,
      ];

  UserState copyWith({
    bool? isUserLoggedIn,
    UserModel? user,
    String? loginErrorMessage,
    bool? isUserAdmin,
    RegisterStatus? registerStatus,
    UserStatus? userStatus,
  }) {
    return UserState(
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
      user: user ?? this.user,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
      isUserAdmin: isUserAdmin ?? this.isUserAdmin,
      registerStatus: registerStatus ?? this.registerStatus,
      userStatus: userStatus ?? this.userStatus,
    );
  }
}
