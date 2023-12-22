

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_radius.dart';



class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.onTapSuffix,
    required this.textInputType,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final IconData? suffixIcon;
  final Function()? onTapSuffix;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'auth.signUp.textFieldError'.tr();
        }
        return null;
      },
      keyboardType: textInputType,
      textInputAction: TextInputAction.next,
      style: TextStyle(color: AppColors.black),
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: AppColors.primary,
          size: 20,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
        ),
        suffix: suffixIcon != null
            ? InkWell(
                onTap: onTapSuffix,
                child: Icon(
                  suffixIcon,
                  color: AppColors.primary,
                  size: 20,
                ),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: radius20,
          borderSide: BorderSide(
            width: 2,
            color: AppColors.primary,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius20,
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius20,
          borderSide: BorderSide(
            width: 2,
            color: AppColors.primary,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius20,
          borderSide: const BorderSide(
            width: 2,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
