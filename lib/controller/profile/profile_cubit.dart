import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_agriculture/core/app_helper/app_dialogs.dart';
import 'package:iot_agriculture/core/app_helper/app_navigator.dart';
import 'package:iot_agriculture/core/constants/app_string.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/models/user_model.dart';
import 'package:iot_agriculture/views/screens/home_screen/home_screen.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  bool isPasswordShow = true;
  late UserModel currentUser;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    emit(ChangePasswordIconState());
  }

  void getCurrentUser() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((value) {
        final data = value.data() as Map<String, dynamic>;
        final UserModel model = UserModel.fromJson(data);
        currentUser = UserModel(
          id: model.id ?? '',
          age: model.age ?? 0,
          name: model.name ?? '',
          email: model.email ?? '',
          deviceId: model.deviceId ?? '',
        );
        emit(GetSuccessState(model));
      }).catchError((error) {
        AppDialog.toast(
          msg: error.toString(),
          color: Colors.red,
        );
      });
    }

    /// Sign Up
  }

  Future<void> editUser({
    required UserModel model,
    required BuildContext context,
  }) async {
    if (model.email == currentUser.email &&
        model.name == currentUser.name &&
        model.age == currentUser.age &&
        model.deviceId == currentUser.deviceId) {
      pushAndRemove(context: context, screen:  const HomeScreen());
      emit(EditSuccessState());
    } else {

      try {
        final firebaseUser = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance
            .collection(AppString.users)
            .doc(firebaseUser!.uid)
            .update(model.toMap());
        await firebaseUser.updateEmail(model.email!);
        pushAndRemove(context: context, screen: const HomeScreen());
        AppDialog.toast(
          msg: 'profile.SuccessUpdate'.tr(),
          color: AppColors.primary,
        );
        emit(EditSuccessState());
      } on FirebaseException catch (e) {
        /// Flutter Toast
        emit(EditErrorState());
        AppDialog.toast(
          msg: e.code,
          color: Colors.red,
        );
        emit(GetSuccessState(model));
      } catch (e) {
        AppDialog.toast(
          msg: e.toString(),
          color: Colors.red,
        );
      }

    }
  }
}
