import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:iot_agriculture/core/constants/images.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/views/widgets/widgets.dart';

class CustomNotFound extends StatelessWidget {
  const CustomNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image(
              height: AppSize.size.height * 0.6,
              width: AppSize.size.width * 0.6,
              image: const Svg(AppImage.empty),
            ),
          ),
          Expanded(
            child: AutoSizeText(
              'home.notfound'.tr(),
              maxLines: 1,
              minFontSize: 9,
              style: mainTextStyle(
                color: AppColors.black,
                size: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
