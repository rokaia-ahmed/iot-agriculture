import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_agriculture/core/app_helper/app_dialogs.dart';
import 'package:iot_agriculture/core/constants/app_string.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/models/user_model.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  static SignupCubit get(BuildContext ctx) => BlocProvider.of(ctx);

  /// FORM KEY
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// CONTROLLERS
  final TextEditingController ageController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController deviceIDController = TextEditingController();

  bool isPasswordShow = true;

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    emit(ChangePasswordSignupState());
  }

  /// Create user
  Future<void> createUser({required UserModel model}) async {
    emit(SignupLoadingState());
    await FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(model.id)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessStates());
    }).catchError((error) {
      emit(CreateUserErrorStates());
      AppDialog.toast(msg: error.toString(), color: Colors.red);
    });
  }

  /// Sign Up
  Future<void> userSignup() async {
    if (formKey.currentState!.validate()) {
      emit(SignupLoadingState());
      try {
        /// CREATE EMAIL AND PASSWORD
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        ).then(
          (value) {
            /// CREATE USER PROFILE
            createUser(
              model: UserModel(
                id: value.user!.uid,
                name: nameController.text,
                deviceId: deviceIDController.text,
                password: passwordController.text,
                email: emailController.text.trim(),
                age: int.parse(ageController.text),
              ),
            );
          },
        );

        emit(SignupSuccessState());

        /// TOAST MSG
        AppDialog.toast(
          msg: 'auth.signUp.signupSuccessfully'.tr(),
          color: AppColors.primary,
        );
      } on FirebaseAuthException catch (e) {
        emit(SignupErrorState());

        /// TOAST MSG
        if (e.code == 'weak-password') {
          AppDialog.toast(
            msg: 'auth.signUp.badPassword'.tr(),
            color: Colors.red,
          );
        } else if (e.code == 'email-already-in-use') {
          AppDialog.toast(
            msg: 'auth.signUp.alreadyUse'.tr(),
            color: Colors.red,
          );
        } else {
          AppDialog.toast(msg: e.code, color: Colors.red);
        }
      } catch (e) {
        /// TOAST MSG
        AppDialog.toast(msg: e.toString(), color: Colors.red);
      }
    }
  }
}
