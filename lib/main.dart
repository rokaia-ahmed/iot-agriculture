import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_agriculture/controller/auth/login/login_cubit.dart';
import 'package:iot_agriculture/controller/auth/signup/signup_cubit.dart';
import 'package:iot_agriculture/controller/home/home_cubit.dart';
import 'package:iot_agriculture/controller/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:iot_agriculture/controller/profile/profile_cubit.dart';
import 'package:iot_agriculture/core/network/local/cache/cache_helper.dart';
import 'package:iot_agriculture/core/style/app_locals.dart';
import 'package:iot_agriculture/core/style/app_theme.dart';
import 'package:iot_agriculture/firebase_options.dart';
import 'package:iot_agriculture/views/screens/splash/splash_screen.dart';


void main() async {
  /// OPEN NATIVE TOOLS FLUTTER NEEDED
  WidgetsFlutterBinding.ensureInitialized();

  /// APP LOCALIZATION
  await EasyLocalization.ensureInitialized();

  await CacheHelper.init();

  /// OPEN FIREBASE
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// SET STATUS BAR COLORS
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark, // ios
      statusBarIconBrightness: Brightness.dark, // android
    ),
  );

  /// SET DISABLE AUTO ROTATE
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  /// START APP
  runApp(
    EasyLocalization(
      path: AppLocales.path,
      startLocale: AppLocales.supportedLocales[1],
      supportedLocales: AppLocales.supportedLocales,
      fallbackLocale: AppLocales.supportedLocales[0],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
      ],
      child: MaterialApp(
        locale: context.locale,
        title: 'IOT Agriculture',
        home: const SplashScreen(),
        theme: appLightTheme,
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
      ),
    );
  }
}
