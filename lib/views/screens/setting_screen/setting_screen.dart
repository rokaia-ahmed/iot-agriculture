import 'package:flutter/material.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/views/screens/setting_screen/setting_components.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5,
        leading: Icon(
          Icons.arrow_back,
          color: AppColors.black,
        ),
      ),
      body: ListView(
        children: [
          HeaderSettingScreen(),
          SizedBox(height: AppSize.height * 0.05),
          SwitchLocalizationSettingScreen(),
          Line(),
          SizedBox(height: AppSize.height * 0.02),
          SwitchThemeSettingScreen(),
          Line(),
          SizedBox(height: AppSize.height * 0.02),
          AboutUs(),
          Line(),
          SizedBox(height: AppSize.height * 0.02),
          ContactUs(),
          Line(),
          SizedBox(height: AppSize.height * 0.02),
        ],
      ),
    );
  }
}
