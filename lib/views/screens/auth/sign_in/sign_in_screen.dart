import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:iot_agriculture/controller/auth/login/login_cubit.dart';
import 'package:iot_agriculture/controller/auth/login/login_states.dart';
import 'package:iot_agriculture/core/app_helper/app_navigator.dart';
import 'package:iot_agriculture/core/constants/images.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_padding.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/views/screens/auth/sign_up/sign_up_screen.dart';
import 'package:iot_agriculture/views/screens/home_screen/home_screen.dart';
import 'package:iot_agriculture/views/widgets/custom_button.dart';
import 'package:iot_agriculture/views/widgets/custom_text_form_field.dart';
import 'package:iot_agriculture/views/widgets/widgets.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginCubit cubit = LoginCubit.get(context);

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          pushAndRemove(
            context: context,
            screen: const HomeScreen(),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: cubit.formKey,
                child: Stack(
                  children: [
                    /// CIRCLES BACKGROUND
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: Svg(AppImage.circleBackground),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    /// IMAGE BOTTOM LEFT
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        AppImage.bottomLogin,
                      ),
                    ),

                    /// SCREEN
                    Center(
                      child: SingleChildScrollView(
                        padding: padding20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state is LoginWithFacebookLoadingState)
                              Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),

                            /// LOGO
                            const Image(image: AssetImage(AppImage.logo)),

                            /// SPACE
                            SizedBox(height: AppSize.height * 0.030),

                            /// TITLE HEADER
                            Text(
                              'Track your crop',
                              style: mainTextStyle(
                                color: AppColors.black,
                                size: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            /// SPACE
                            SizedBox(height: AppSize.height * 0.030),

                            /// EMAIL TEXT FORM FIELD
                            CustomTextFormField(
                              prefixIcon: Icons.account_circle,
                              controller: cubit.emailController,
                              hintText: 'auth.login.email'.tr(),
                              textInputType: TextInputType.emailAddress,
                            ),

                            /// SPACE
                            SizedBox(height: AppSize.height * 0.020),

                            /// PASSWORD TEXT FORM FIELD
                            CustomTextFormField(
                              prefixIcon: Icons.key,
                              obscureText: cubit.isPasswordShow,
                              controller: cubit.passwordController,
                              hintText: 'auth.login.password'.tr(),
                              textInputType: TextInputType.visiblePassword,
                              suffixIcon: cubit.isPasswordShow
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              onTapSuffix: () {
                                cubit.changePasswordVisibility();
                              },
                            ),

                            /// SPACE
                            SizedBox(height: AppSize.height * .020),

                            /// LOGIN BUTTON
                            CustomButton(
                              textColor: AppColors.black,
                              height: AppSize.height * .06,
                              function: () => cubit.login(),
                              text: 'auth.login.login'.tr(),
                              backgroundColor: AppColors.primary,
                            ),

                            /// SPACE
                            SizedBox(height: AppSize.height * .028),

                            /// TEXT LOGIN OR LOGIN WITH
                            Text(
                              'auth.login.orLoginWith'.tr(),
                              style: mainTextStyle(
                                color: AppColors.black,
                                size: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            /// SPACE
                            SizedBox(height: AppSize.height * .035),

                            /// FACEBOOK OR GOOGLE
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /// FACEBOOK BUTTON
                                CustomButton(
                                  height: AppSize.height * .06,
                                  width: AppSize.width * .4,
                                  function: () {
                                    cubit.loginWithFacebook(context);
                                  },
                                  text: 'auth.login.facebook'.tr(),
                                  textColor: AppColors.white,
                                  backgroundColor:
                                      AppColors.facebookButtonColor,
                                ),

                                /// GOOGLE BUTTON
                                CustomButton(
                                  height: AppSize.height * .06,
                                  width: AppSize.width * .4,
                                  function: () =>
                                      cubit.signInWithGoogle(context),
                                  text: 'auth.login.google'.tr(),
                                  textColor: AppColors.white,
                                  backgroundColor: AppColors.googleButtonColor,
                                ),
                              ],
                            ),

                            /// SPACE
                            SizedBox(height: AppSize.height * .025),
                            if (Platform.isIOS)
                              SignInWithAppleButton(
                                onPressed: () => cubit.signInWithApple(),
                              ),
                            if (Platform.isIOS)
                              SizedBox(height: AppSize.height * .025),

                            /// TEXT NOT HAVE ACCOUNT
                            Text(
                              'auth.login.doNotHaveAccount'.tr(),
                              style: mainTextStyle(
                                size: 18,
                                color: AppColors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            /// SIGN UP SCREEN
                            TextButton(
                              onPressed: () {
                                push(
                                  context: context,
                                  screen: const SignUpScreen(),
                                );
                              },
                              child: Text(
                                'auth.login.signUp'.tr(),
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Montserrat',
                                  color: AppColors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
