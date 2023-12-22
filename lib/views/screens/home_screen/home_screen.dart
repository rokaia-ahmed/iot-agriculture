import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:iot_agriculture/controller/profile/profile_cubit.dart';
import 'package:iot_agriculture/core/constants/images.dart';
import 'package:iot_agriculture/core/network/remote/remote.dart';
import 'package:iot_agriculture/core/style/app_colors.dart';
import 'package:iot_agriculture/core/style/app_padding.dart';
import 'package:iot_agriculture/core/style/app_size.dart';
import 'package:iot_agriculture/views/widgets/custom_not_found.dart';
import 'package:iot_agriculture/views/widgets/loading_bar.dart';
import 'package:iot_agriculture/views/widgets/widgets.dart';


/// ToDo User Address
/// ToDo Hide[Temp] if no Device Data
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String deviceId = '';
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).getCurrentUser();
  }

  final List<Color> readersColors = [
    AppColors.humidityColor,
    AppColors.npkColor,
    AppColors.phColor,
    AppColors.coColor,
    AppColors.sanilityColor,
    AppColors.amoniaColor,
  ];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor2,
        body: Padding(
          padding: AppPadding.symmetricPadding30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    height: AppSize.size.height * 0.045,
                    width: AppSize.size.width * 0.09,
                    image: const Svg(AppImage.homeIcon),
                  ),
                  SizedBox(
                    width: AppSize.size.width * 0.009,
                  ),
                  AutoSizeText(
                    'home.title'.tr(),
                    minFontSize: 11,
                    maxLines: 1,
                    style: mainTextStyle(
                      color: AppColors.black,
                      size: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    /// ToDo Add [Notification Screen] Navigator
                    onTap: () {},
                    child: const Icon(
                      Icons.notifications_active,
                      size: 25,
                    ),
                  ),
                ],
              ),
              Divider(
                color: AppColors.vLightGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText.rich(
                    maxLines: 2,
                    minFontSize: 7,
                    overflow: TextOverflow.ellipsis,
                    TextSpan(
                      text: '${'home.crops'.tr()}\n',
                      style: mainTextStyle(
                        color: Colors.black,
                        size: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: 'home.loc'.tr(),
                          style: mainTextStyle(
                            color: Colors.black,
                            size: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image(
                    height: AppSize.size.height * 0.05,
                    width: AppSize.size.width * 0.065,
                    image: const Svg(AppImage.locationIcon),
                  ),
                ],
              ),
              Divider(
                color: AppColors.vLightGrey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image(
                        height: AppSize.size.height * 0.05,
                        width: AppSize.size.width * 0.09,
                        image: const Svg(AppImage.sunIcon),
                      ),
                      SizedBox(
                        width: AppSize.size.width * 0.01,
                      ),
                      AutoSizeText(
                        '62°F',
                        minFontSize: 7,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: mainTextStyle(
                          color: Colors.black,
                          size: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image(
                        height: AppSize.size.height * 0.04,
                        width: AppSize.size.width * 0.08,
                        image: const Svg(AppImage.humidityIcon),
                      ),
                      SizedBox(
                        width: AppSize.size.width * 0.01,
                      ),
                      AutoSizeText(
                        'home.humidity'.tr(),
                        style: mainTextStyle(
                          color: Colors.black,
                          size: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        minFontSize: 7,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: AppColors.vLightGrey,
              ),
              SizedBox(height: AppSize.height * 0.02,),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is GetSuccessState) {
                    final user = state.user;
                    deviceId = user.deviceId.toString();
                    return Expanded(
                      child: StreamBuilder<DatabaseEvent>(
                        stream: RemoteRepo.getHomeData(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<DatabaseEvent> snapshot,
                        ) {
                          final List values = [];
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            values.add(snapshot.data!.snapshot.value);
                            if (values[0][deviceId] == null) {
                              return const CustomNotFound();
                            } else {
                              final Map map = values[0][deviceId] as Map;
                              final List<String> title = [];
                              final List<double> value = [];
                              map.forEach((k, v) {
                                title.add(k.toString());
                                value.add(double.parse(v.toString()));
                              });
                              return ListView.separated(
                                separatorBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    height: AppSize.height * 0.03,
                                  );
                                },
                                itemCount: title.length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        LoadingBar(
                                  readerColor: readersColors[Random().nextInt(6)],
                                  readerName: title[index],
                                  readerPrecentage: value[index],
                                ),
                              );
                            }
                          } else if (snapshot.hasData &&
                              snapshot.data == null) {
                            return const CustomNotFound();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
