import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_agriculture/controller/profile/profile_cubit.dart';
import 'package:iot_agriculture/core/constants/images.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_padding.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/models/user_model.dart';
import 'package:iot_agriculture/views/widgets/custom_button.dart';
import 'package:iot_agriculture/views/widgets/custom_text_form_field.dart';
import 'package:iot_agriculture/views/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // FORM KEY
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // NAME CONTROLLER
  TextEditingController nameController = TextEditingController();
  // EMAIL CONTROLLER
  TextEditingController emailController = TextEditingController();
  // AGE CONTROLLER
  TextEditingController ageController = TextEditingController();
  // AGE CONTROLLER
  TextEditingController deviceIDController = TextEditingController();

  @override
  void initState() {
    /// GET DATA OF USER
    BlocProvider.of<ProfileCubit>(context).getCurrentUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is GetSuccessState) {
          final user = state.user;

          /// DATA OF USER
          ageController.text = user.age.toString();
          nameController.text = user.name.toString();
          emailController.text = user.email.toString();
          deviceIDController.text = user.deviceId.toString();

          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.scaffoldBackgroundColor,
              appBar: AppBar(
                iconTheme: IconThemeData(color: AppColors.primary),
                backgroundColor: AppColors.scaffoldBackgroundColor,
                elevation: 0,
              ),
              body: SingleChildScrollView(
                padding: AppPadding.padding007,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      /// HEADER TITLE
                      Text(
                        'profile.ProfileTitle'.tr(),
                        style: mainTextStyle(
                          color: AppColors.black,
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      /// SPACE
                      SizedBox(height: AppSize.height * .028),

                      /// HEADER LOGO
                      Center(
                        child: Container(
                          width: AppSize.height*0.2,
                          height: AppSize.height*0.2,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(AppImage.profile),
                              fit: BoxFit.contain,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      /// SPACE
                      SizedBox(height: AppSize.height * 0.015),

                      /// DEVICE ID TEXT FORM FIELD
                      CustomTextFormField(
                        controller: deviceIDController,
                        textInputType: TextInputType.name,
                        hintText: 'auth.signUp.deviceId'.tr(),
                        prefixIcon: Icons.ad_units_rounded,
                      ),

                      /// SPACE
                      SizedBox(height: AppSize.height * .028),

                      /// NAME TEXT FORM FIELD
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

                      /// Save Button
                      CustomButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.editUser(
                              context: context,
                              model: UserModel(
                                id: user.id,
                                name: nameController.text,
                                deviceId: deviceIDController.text,
                                email: emailController.text.trim(),
                                age: int.parse(ageController.text),
                              ),
                            );
                          }
                        },
                        text: 'profile.save'.tr(),
                        textColor: AppColors.black,
                        backgroundColor: AppColors.primary,
                        height: AppSize.height * .06,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          /// LOADING
          return SafeArea(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
