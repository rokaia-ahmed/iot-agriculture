import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';

import 'package:iot_agriculture/core/style/app_padding.dart';
import 'package:iot_agriculture/core/style/app_radius.dart';
import 'package:iot_agriculture/core/style/app_size.dart';


class HeaderSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.padding001,
      child: Container(
        width: AppSize.width * 0.2,
        height: AppSize.width * 0.2,
        decoration: BoxDecoration(
          color: AppColors.lightGrey2,
          borderRadius: AppRadius.radius20,
        ),
        child: Padding(
          padding: AppPadding.padding001,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundColor: AppColors.white,
                  radius: 22,
                  child: Icon(
                    Icons.edit,
                    color: AppColors.black,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: AppPadding.padding001,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const AutoSizeText(
                      'Mohamed Ehap Mohamed',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: AppSize.height * 0.01,
                    ),
                    const AutoSizeText(
                      '+201124576914',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 27,
                child: AutoSizeText(
                  'M',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SwitchLocalizationSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.paddingV001,
      width: double.infinity,
      height: AppSize.height * 0.1,
      color: Colors.white,
      child: Row(
        children: [
          const Icon(
            Icons.language_outlined,
            color: Colors.black54,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: AppPadding.paddingleft001,
              child: AutoSizeText(
                'Change\nLanguage',
                style: TextStyle(
                  fontSize: 18.0,
                  color: AppColors.black54,
                ),
              ),
            ),
          ),
          SizedBox(
            width: AppSize.width * 0.1,
          ),
          AutoSizeText(
            'ChangeToArabic',
            style: TextStyle(
              fontSize: 12.0,
              color: AppColors.black54,
            ),
          ),
          const Spacer(),
          SizedBox(
            child: FlutterSwitch(
              width: AppSize.width * 0.180,
              height: AppSize.height * 0.050,
              valueFontSize: 15.0,
              toggleSize: AppSize.width * 0.070,
              value: true,
              borderRadius: 30.0,
              padding: 1.0,
              activeColor: AppColors.primary,
              inactiveColor: Colors.grey.shade300,
              onToggle: (val) {},
            ),
          ),
        ],
      ),
    );
  }
}

class SwitchThemeSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPadding.paddingV001,
      width: double.infinity,
      height: AppSize.height * 0.1,
      color: Colors.white,
      child: Row(
        children: [
          const Icon(
            Icons.brightness_4_outlined,
            color: Colors.black54,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: AppPadding.paddingleft001,
              child: AutoSizeText(
                'Change Theme',
                style: TextStyle(
                  fontSize: 18.0,
                  color: AppColors.black54,
                ),
              ),
            ),
          ),
          const Spacer(),
          FlutterSwitch(
            width: AppSize.width * 0.180,
            height: AppSize.height * 0.050,
            valueFontSize: 15.0,
            toggleSize: AppSize.width * 0.070,
            value: true,
            borderRadius: 30.0,
            padding: 1.0,
            activeColor: AppColors.primary,
            inactiveColor: Colors.grey.shade300,
            onToggle: (val) {},
          ),
        ],
      ),
    );
  }
}

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: AppPadding.paddingV001,
        width: double.infinity,
        height: AppSize.height * 0.1,
        color: AppColors.white,
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: AppColors.black54,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: AppPadding.paddingleft001,
                child: AutoSizeText(
                  'About Us',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.black54,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppSize.width * 0.050,
              color: AppColors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: AppPadding.paddingV001,
        width: double.infinity,
        height: AppSize.height * 0.1,
        color: AppColors.white,
        child: Row(
          children: [
            Icon(
              Icons.call_outlined,
              color: AppColors.black54,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: AppPadding.paddingleft001,
                child: AutoSizeText(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppColors.black54,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: AppSize.width * 0.050,
              color: AppColors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

class Line extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSize.height * 0.002,
      color: AppColors.black26,
    );
  }
}
