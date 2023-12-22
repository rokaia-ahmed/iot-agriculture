import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:iot_agriculture/core/app_helper/app_navigator.dart';
import 'package:iot_agriculture/core/constants/images.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_padding.dart';
import 'package:iot_agriculture/core/style/app_radius.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/views/screens/auth/sign_in/sign_in_screen.dart';
import 'package:iot_agriculture/views/screens/on_boarding/on_boarding_screen.dart';

import '../../../core/network/local/cache/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> with TickerProviderStateMixin {
  Duration animationDuration = const Duration(seconds: 5);

  AnimationController? _controller;

  late Animation<double> slideAnimation;

  double slideBegin = 0.0;
  double slideEnd = 1.0;
  bool onBoarding = (CacheHelper.getData(key: 'onBoarding') ?? false) as bool;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: animationDuration, vsync: this);

    final Animation curve = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOutCubic,
    );

    slideAnimation = Tween(
      begin: slideBegin,
      end: slideEnd,
    ).animate(curve as Animation<double>);

    _controller?.addListener(() {
      if (_controller?.isCompleted == true) {
        pushAndRemove(
          context: context,
          screen: onBoarding ? const SignInScreen() : OnBoardingScreen(),
        );
      }
    });

    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: padding20,
        width: double.infinity,
        height: double.infinity,

        /// CIRCLES BACKGROUND
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: Svg(AppImage.circleBackground),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          children: [
            /// IOT LOGO IN CENTER
            Expanded(
              child: Image.asset(AppImage.logo),
            ),

            /// BUTTON LOADING
            Stack(
              children: [
                Container(
                  height: AppSize.height * 0.06,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(0.4),
                    borderRadius: radius20,
                    border: Border.all(color: AppColors.loadingBg),
                  ),
                  child: Center(
                    child: Text(
                      'splash.loading'.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller!,
                  builder: (BuildContext context, Widget? child) {
                    return ClipPath(
                      clipper: RectClipper(
                        slideAnimation.value,
                        TransitionType.LEFT_TO_RIGHT,
                      ),
                      child: child,
                    );
                  },
                  child: Container(
                    height: AppSize.height * 0.06,
                    decoration: BoxDecoration(
                      color: primary,
                      borderRadius: radius20,
                      border: Border.all(color: AppColors.greenColor),
                    ),
                    child: Center(
                      child: Text(
                        'splash.loading'.tr(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
