abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangePasswordState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LogoutSuccessState extends LoginState {}

class LoginErrorState extends LoginState {}

class SaveUserSuccessState extends LoginState {}

class SaveUserErrorState extends LoginState {}

class LoginWithFacebookLoadingState extends LoginState {}

class LoginWithFacebookSuccessState extends LoginState {}

class LoginWithFacebookErrorState extends LoginState {}
