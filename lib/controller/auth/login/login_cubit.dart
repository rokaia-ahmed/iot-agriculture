import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iot_agriculture/controller/auth/login/login_states.dart';
import 'package:iot_agriculture/core/app_helper/app_dialogs.dart';
import 'package:iot_agriculture/core/app_helper/app_navigator.dart';
import 'package:iot_agriculture/core/constants/app_string.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/models/user_model.dart';
import 'package:iot_agriculture/views/screens/auth/sign_up/complete_sign_up_screen.dart';
import 'package:iot_agriculture/views/screens/home_screen/home_screen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext ctx) => BlocProvider.of(ctx);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordShow = true;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  void changePasswordVisibility() {
    isPasswordShow = !isPasswordShow;
    emit(ChangePasswordState());
  }

  /// Auth Login
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoginLoadingState());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        emit(LoginSuccessState());
        AppDialog.toast(
          msg: 'auth.login.loginSuccessfully'.tr(),
          color: AppColors.primary,
        );
      } on FirebaseAuthException catch (e) {
        /// Flutter Toast
        emit(LoginErrorState());
        if (e.code == 'user-not-found') {
          AppDialog.toast(
            msg: 'auth.login.userNotFound'.tr(),
            color: Colors.red,
          );
        } else if (e.code == 'wrong-password') {
          AppDialog.toast(
            msg: 'auth.login.wrongPassword'.tr(),
            color: Colors.red,
          );
        } else {
          AppDialog.toast(
            msg: e.code,
            color: Colors.red,
          );
        }
      } catch (e) {
        AppDialog.toast(
          msg: e.toString(),
          color: Colors.red,
        );
      }
    }
  }

  Future<void> saveUser({required UserModel model}) async {
    /// STORE USER DATA IN FIRESTORE
    await FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(model.id)
        .set(model.toMap())
        .then((value) {
      /// WHEN DONE STORE DATA
      emit(SaveUserSuccessState());
      AppDialog.toast(
        msg: 'auth.signUp.dataSaved'.tr(),
        color: AppColors.primary,
      );
    }).catchError((error) {
      /// WHEN ERROR IN STORE DATA
      emit(SaveUserErrorState());
      AppDialog.toast(
        msg: error.toString(),
        color: Colors.red,
      );
    });
  }

  Future<void> checkUser({
    required User user,
    required BuildContext context,
  }) async {
    /// CHECK USER HAVE AN ACCOUNT OR NO
    await FirebaseFirestore.instance
        .collection(AppString.users)
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        /// IF HAVE AN ACCOUNT -> HOME
        push(
          context: context,
          screen: const HomeScreen(),
        );
      } else {
        /// IF HAVEN'T AN ACCOUNT -> COMPLETE ENTER DATA
        push(
          context: context,
          screen: CompleteSignUpScreen(user: user),
        );
      }
    }).catchError((error) {
      ///  WHEN ERROR
      AppDialog.toast(
        msg: error.toString(),
        color: Colors.red,
      );
    });
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      /// SELECT USER ACCOUNT
      await googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        if (googleAuth.accessToken != null || googleAuth.idToken != null) {
          final credential = GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          );
          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          final User? user = userCredential.user;

          if (user != null) {
            /// TOAST DONE LOGIN
            AppDialog.toast(
              msg: 'auth.login.loginSuccessfully'.tr(),
              color: AppColors.primary,
            );

            /// CHECK THIS  USER HAVE AN ACCOUNT OR NO
            await checkUser(user: user, context: context);
          }
          emit(LoginSuccessState());
        }
      }
    } catch (e) {
      /// WHEN ERROR
      emit(LoginErrorState());
      AppDialog.toast(
        msg: e.toString(),
        color: Colors.red,
      );
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(LogoutSuccessState());
    } catch (e) {
      AppDialog.toast(
        msg: e.toString(),
        color: Colors.red,
      );
    }
  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signInWithApple() async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final authCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(authCredential);
      final nameDisplay =
          '${appleCredential.givenName} ${appleCredential.familyName}';
      final userEmail = '${appleCredential.email}';
      final firebaseUser = authResult.user;
      await firebaseUser!.updateProfile(displayName: nameDisplay);
      await firebaseUser.updateEmail(userEmail);
      emit(LoginSuccessState());
      AppDialog.toast(
        msg: 'auth.login.loginSuccessfully'.tr(),
        color: AppColors.primary,
      );
    } catch (e) {
      AppDialog.toast(
        msg: e.toString(),
        color: Colors.red,
      );
    }
  }

//TODO FB LOGIN
  Future<void> loginWithFacebook(BuildContext context) async {
    try {
      emit(LoginWithFacebookLoadingState());
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );
      final userData = await FacebookAuth.instance.getUserData();
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(
        loginResult.accessToken!.token,
      );
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

      await FirebaseFirestore.instance.collection(AppString.users).add({
        'id': userData['id'],
        'name': userData['name'],
        'email': userData['email'],
      });
      AppDialog.toast(
        msg: 'auth.login.loginFacebookSuccessfully'.tr(),
        color: AppColors.primary,
      );
      pushAndRemove(context: context, screen: const HomeScreen());
      emit(LoginWithFacebookSuccessState());
    } on FirebaseAuthException catch (e) {
      pushAndRemove(context: context, screen: const HomeScreen());
      emit(LoginWithFacebookSuccessState());
      emit(LoginWithFacebookErrorState());
      if (e.code == 'invalid_credential') {
        AppDialog.toast(
          msg: 'auth.login.loginFacebookFailed'.tr(),
          color: Colors.red,
        );
      } else {
        AppDialog.toast(
          msg: e.code,
          color: Colors.red,
        );
      }
    }
  }
}
