import 'package:auto_size_text/auto_size_text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_agriculture/controller/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:iot_agriculture/controller/on_boarding_cubit/on_boarding_states.dart';
import 'package:iot_agriculture/core/app_helper/app_navigator.dart';
import 'package:iot_agriculture/core/constants/images.dart';
import 'package:iot_agriculture/core/network/local/cache/cache_helper.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_padding.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/models/on_boarding_model.dart';
import 'package:iot_agriculture/views/screens/auth/sign_in/sign_in_screen.dart';
import 'package:iot_agriculture/views/screens/on_boarding/on_boarding_card.dart';
import 'package:iot_agriculture/views/widgets/custom_background.dart';
import 'package:iot_agriculture/views/widgets/custom_button.dart';
import 'package:iot_agriculture/views/widgets/widgets.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  final PageController controller = PageController();
  final List<OnBoardingModel> boarding = [
    OnBoardingModel(
      image: AppImage.onBoarding1,
      title: 'on_boarding1.title'.tr(),
      desc: 'on_boarding1.desc'.tr(),
    ),
    OnBoardingModel(
      image: AppImage.onBoarding2,
      title: 'on_boarding2.title'.tr(),
      desc: 'on_boarding2.desc'.tr(),
    ),
    OnBoardingModel(
      image: AppImage.onBoarding3,
      title: 'on_boarding3.title'.tr(),
      desc: 'on_boarding3.desc'.tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = OnBoardingCubit.get(context);
    void submit() {
      CacheHelper.saveData(
        key: 'onBoarding',
        value: true,
      ).then(
        (value) {
          pushAndRemove(
            context: context,
            screen: const SignInScreen(),
          );
        },
      );
    }

    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: CustomBackground(
            child: Padding(
              padding: padding20,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (index) {
                        cubit.updateIndexValue(value: index);
                      },
                      physics: const BouncingScrollPhysics(),
                      controller: controller,
                      itemBuilder: (context, index) {
                        return OnBoardingCard(model: boarding[index]);
                      },
                      itemCount: boarding.length,
                    ),
                  ),
                  Center(
                    child: DotsIndicator(
                      dotsCount: boarding.length,
                      position: double.parse(cubit.index.toString()),
                      decorator: DotsDecorator(
                        color: primary.withOpacity(0.6),
                        size: const Size.square(11.0),
                        activeSize: const Size(11.0, 11.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        activeColor: primary,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.height * 0.050),
                  AutoSizeText.rich(
                    TextSpan(
                      text: 'you_can'.tr(),
                      style: mainTextStyle(
                        color: AppColors.lightGrey,
                        size: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: 'skip'.tr(),
                          style: mainTextStyle(
                            color: AppColors.lightGrey,
                            size: 12,
                            fontWeight: FontWeight.bold,
                          ).copyWith(decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => submit(),
                        ),
                      ],
                    ),
                    minFontSize: 8,
                    maxLines: 1,
                  ),
                  SizedBox(height: AppSize.height * 0.050),
                  CustomButton(
                    function: () {
                      if (cubit.index < boarding.length - 1) {
                        controller.animateToPage(
                          cubit.index + 1,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInCubic,
                        );
                      } else {
                        submit();
                      }
                    },
                    text: 'next'.tr(),
                    textColor: white,
                    backgroundColor: primary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
