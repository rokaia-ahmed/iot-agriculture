part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ChangePasswordIconState extends ProfileState {}

class SignOutState extends ProfileState {}

class GetSuccessState extends ProfileState {
  GetSuccessState(this.user);

  final UserModel user;
}

class EditSuccessState extends ProfileState {}

class EditErrorState extends ProfileState {}

class SignupErrorState extends ProfileState {}
