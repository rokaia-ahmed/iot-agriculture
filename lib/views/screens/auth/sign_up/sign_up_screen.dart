import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_agriculture/controller/auth/signup/signup_cubit.dart';
import 'package:iot_agriculture/core/app_helper/app_navigator.dart';
import 'package:iot_agriculture/core/constants/images.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_padding.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/views/screens/auth/sign_in/sign_in_screen.dart';
import 'package:iot_agriculture/views/screens/home_screen/home_screen.dart';
import 'package:iot_agriculture/views/widgets/custom_background.dart';
import 'package:iot_agriculture/views/widgets/custom_button.dart';
import 'package:iot_agriculture/views/widgets/custom_text_form_field.dart';
import 'package:iot_agriculture/views/widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupCubit cubit = SignupCubit.get(context);
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is CreateUserSuccessStates) {
          pushAndRemove(
            context: context,
            screen: const HomeScreen(),
          );
        }
      },
      builder: (context, state) {
        if (state is SignupLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: primary),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: CustomBackground(
                child: Form(
                  key: cubit.formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: padding20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// LOGO
                          const Image(image: AssetImage(AppImage.logo)),

                          /// SPACE
                          SizedBox(height: AppSize.height * 0.030),

                          /// TITLE HEADER
                          Text(
                            'auth.signUp.signUp'.tr(),
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * 0.030),

                          /// DEVICE ID TEXT FORM FIELD
                          CustomTextFormField(
                            textInputType: TextInputType.name,
                            prefixIcon: Icons.ad_units_rounded,
                            controller: cubit.deviceIDController,
                            hintText: 'auth.signUp.deviceId'.tr(),
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .020),

                          /// USER NAME TEXT FORM FIELD
                          CustomTextFormField(
                            controller: cubit.nameController,
                            prefixIcon: Icons.account_circle,
                            textInputType: TextInputType.name,
                            hintText: 'auth.signUp.userName'.tr(),
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .020),

                          /// EMAIL TEXT FORM FIELD
                          CustomTextFormField(
                            prefixIcon: Icons.email,
                            controller: cubit.emailController,
                            hintText: 'auth.signUp.email'.tr(),
                            textInputType: TextInputType.emailAddress,
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .020),

                          /// PASSWORD TEXT FORM FIELD
                          CustomTextFormField(
                            prefixIcon: Icons.key,
                            obscureText: cubit.isPasswordShow,
                            controller: cubit.passwordController,
                            hintText: 'auth.signUp.password'.tr(),
                            textInputType: TextInputType.visiblePassword,
                            suffixIcon: cubit.isPasswordShow
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            onTapSuffix: () => cubit.changePasswordVisibility(),
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .020),

                          /// AGE TEXT FORM FIELD
                          CustomTextFormField(
                            controller: cubit.ageController,
                            hintText: 'auth.signUp.age'.tr(),
                            prefixIcon: Icons.calendar_month,
                            textInputType: TextInputType.number,
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .030),

                          /// LOGIN BUTTON
                          CustomButton(
                            textColor: AppColors.black,
                            height: AppSize.height * .06,
                            text: 'auth.signUp.signUp'.tr(),
                            backgroundColor: AppColors.primary,
                            function: () => cubit.userSignup(),
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .03),

                          /// YOU HAVE ACCOUNT TEXT
                          Text(
                            'auth.signUp.haveAnAccount'.tr(),
                            style: mainTextStyle(
                              color: AppColors.black,
                              size: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          /// SIGN UP BUTTON
                          TextButton(
                            onPressed: () {
                              push(
                                context: context,
                                screen: const SignInScreen(),
                              );
                            },
                            child: Text(
                              'auth.signUp.login'.tr(),
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
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
