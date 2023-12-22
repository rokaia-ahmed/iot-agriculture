import 'package:flutter/material.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/models/on_boarding_model.dart';
import 'package:iot_agriculture/views/widgets/widgets.dart';

class OnBoardingCard extends StatelessWidget {
  const OnBoardingCard({
    super.key,
    required this.model,
  });

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          model.image,
          width: AppSize.width * 0.9,
          height: AppSize.height * 0.4,
        ),
        SizedBox(height: AppSize.height * 0.040),
        Text(
          model.title,
          style: mainTextStyle(
            size: 30,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppSize.height * 0.025),
        Center(
          child: Text(
            model.desc,
            textAlign: TextAlign.center,
            style: mainTextStyle(
              color: AppColors.black,
              size: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
