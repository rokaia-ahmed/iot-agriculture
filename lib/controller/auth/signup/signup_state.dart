part of 'signup_cubit.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class ChangePasswordSignupState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupErrorState extends SignupState {}

class CreateUserSuccessStates extends SignupState {}

class CreateUserErrorStates extends SignupState {}
