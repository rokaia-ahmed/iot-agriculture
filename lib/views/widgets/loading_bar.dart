import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_radius.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/views/widgets/widgets.dart';

class LoadingBar extends StatelessWidget {
  const LoadingBar({
    required this.readerColor,
    required this.readerName,
    required this.readerPrecentage,
  });

  final Color readerColor;
  final String readerName;
  final double readerPrecentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              readerName,
              maxLines: 1,
              minFontSize: 9,
              style: mainTextStyle(
                color: Colors.black,
                size: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            AutoSizeText(
              '$readerPrecentage%',
              minFontSize: 9,
              maxLines: 1,
              style: mainTextStyle(
                color: Colors.black,
                // ignore: require_trailing_commas
                size: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        SizedBox(
          height: AppSize.height * 0.015,
        ),
        Stack(
          children: [
            Container(
              height: AppSize.height * 0.01,
              width: AppSize.width,
              decoration: BoxDecoration(
                color: AppColors.lightGrey2,
                border: Border.all(
                  color: AppColors.lightGrey2,
                ),
                borderRadius: AppRadius.radius10,
              ),
            ),
            Container(
              height: AppSize.height * 0.01,
              width: (AppSize.width * readerPrecentage) / 100,
              decoration: BoxDecoration(
                color: readerColor,
                border: Border.all(
                  color: readerColor,
                ),
                borderRadius: AppRadius.radius10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
