import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:iot_agriculture/models/user_model.dart';
import 'package:iot_agriculture/views/screens/home_screen/home_screen.dart';
import 'package:iot_agriculture/views/widgets/custom_button.dart';
import 'package:iot_agriculture/views/widgets/custom_text_form_field.dart';

class CompleteSignUpScreen extends StatelessWidget {
  CompleteSignUpScreen({super.key, required this.user});

  final User? user;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController deviceIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cubit = LoginCubit.get(context);
    if (user!.email!.isNotEmpty) {
      emailController.text = user!.email!;
    }
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Stack(
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

                /// SCREEN
                Center(
                  child: SingleChildScrollView(
                    padding: AppPadding.padding001,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /// LOGO
                          const Image(image: AssetImage(AppImage.logo)),

                          /// SPACE
                          SizedBox(height: AppSize.height * 0.015),

                          /// USER NAME TEXT FORM FIELD
                          CustomTextFormField(
                            controller: nameController,
                            textInputType: TextInputType.name,
                            hintText: 'auth.signUp.userName'.tr(),
                            prefixIcon: Icons.account_circle,
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .028),

                          /// EMAIL TEXT FORM FIELD
                          CustomTextFormField(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            hintText: 'auth.signUp.email'.tr(),
                            prefixIcon: Icons.email,
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .028),

                          /// AGE TEXT FORM FIELD
                          CustomTextFormField(
                            controller: ageController,
                            textInputType: TextInputType.number,
                            hintText: 'auth.signUp.age'.tr(),
                            prefixIcon: Icons.calendar_month,
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .028),

                          /// Device Address TEXT FORM FIELD
                          CustomTextFormField(
                            controller: deviceIdController,
                            textInputType: TextInputType.text,
                            hintText: 'auth.signUp.deviceId'.tr(),
                            prefixIcon: Icons.mobile_friendly,
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .035),

                          /// LOGIN BUTTON
                          CustomButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.saveUser(
                                  model: UserModel(
                                    id: user!.uid,
                                    email: emailController.text,
                                    name: nameController.text,
                                    age: int.parse(ageController.text),
                                    deviceId: deviceIdController.text,
                                  ),
                                );
                                pushAndRemove(
                                  context: context,
                                  screen: const HomeScreen(),
                                );
                              }
                            },
                            text: 'auth.signUp.save'.tr(),
                            textColor: AppColors.black,
                            backgroundColor: AppColors.primary,
                            height: AppSize.height * .06,
                          ),

                          /// SPACE
                          SizedBox(height: AppSize.height * .03),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
