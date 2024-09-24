import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:mo_wahaj_top/core/widget/footer/contact_us_footer.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/activity/presentation/cubit/sub_activity_cubit/sub_activity_cubit.dart';
import 'package:mo_wahaj_top/features/activity/presentation/cubit/sub_activity_cubit/sub_activity_state.dart';
import 'package:mo_wahaj_top/features/activity/presentation/widget/sub_activity_ads_item.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/home/dot_indicator_widget.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import '../cubit/sub_activity_ads_cubit/sub_activity_ads_cubit.dart';
import '../cubit/sub_activity_ads_cubit/sub_activity_ads_state.dart';
import '../widget/sub_activity_list.dart';

class SubActivityArgs {
  String collectionName;
  String adsCollectionName;
  String subActivityArName;
  String subActivityEnName;

  SubActivityArgs(
      {required this.collectionName,
      required this.subActivityArName,
      required this.adsCollectionName,
      required this.subActivityEnName});
}

class SubActivityScreen extends StatefulWidget {
  const SubActivityScreen({super.key, required this.args});

  final SubActivityArgs args;

  @override
  State<SubActivityScreen> createState() => _SubActivityScreenState();
}

class _SubActivityScreenState extends State<SubActivityScreen> {
  bool hasAdsData = true;
  bool hasActivityData = true;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        title: AppText(
          text: LanguageHelper.isEnglishAppLanguage()
              ? widget.args.subActivityEnName
              : widget.args.subActivityArName,
          fontWeight: FontWeight.w600,
          fontSize: AppFontSize.sp18,
          fontColor: AppColor.navy,
        ),
        actions: [
          Visibility(
            visible: AppSharedPreferences.isLogin() == true,
            child: Padding(
              padding: EdgeInsets.only(
                  right: AppWidthSize.w5, left: AppWidthSize.w5),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.search);
                    },
                    child: SvgPicture.asset(
                      AppIcon.search,
                      colorFilter: const ColorFilter.mode(
                          AppColor.black, BlendMode.srcIn),
                    ),
                  ),
                  SizedBox(width: AppWidthSize.w6),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteName.notification);
                    },
                    child: SvgPicture.asset(
                      AppIcon.notification,
                      colorFilter: const ColorFilter.mode(
                          AppColor.black, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<SubActivityCubit>().getSubActivities(
              activityCollectionName: widget.args.collectionName);
          context.read<SubActivityAdsCubit>().getSubActivityAds(
              activityAdsCollectionName: widget.args.adsCollectionName);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<SubActivityAdsCubit, SubActivityAdsState>(
                listener: (context, state) {
                  if (state.status == CubitStatus.error) {
                    NoteMessage.showErrorSnackBar(
                        context: context, text: state.model.error ?? "");
                  }
                },
                builder: (context, state) {
                  if (state.status == CubitStatus.loading) {
                    return const SizedBox();
                  }

                  List<Map<String, dynamic>> subActivitiesAds =
                      (state.model.data?['ads'] ?? [])
                          .cast<Map<String, dynamic>>();
                  List<Map<String, dynamic>> subActivitiesAdsVisible =
                      subActivitiesAds
                          .where((element) => element['is_visible'] == true)
                          .toList();
                  return Visibility(
                    visible: subActivitiesAdsVisible.isNotEmpty,
                    child: Column(
                      children: [
                        subActivitiesAdsVisible.length == 1
                            ? SubActivityAdsItem(
                                action:
                                    subActivitiesAdsVisible.first['action'] ??
                                        "",
                                url: subActivitiesAdsVisible.first['url'] ?? "",
                                subActivityObj: subActivitiesAdsVisible.first,
                                activityObj: subActivitiesAdsVisible.first,
                                collectionName: subActivitiesAdsVisible
                                        .first['collection_name'] ??
                                    "",
                                adsCollectionName: subActivitiesAdsVisible
                                        .first['ads_collection_name'] ??
                                    "",
                                enName:
                                    subActivitiesAdsVisible.first['en_name'] ??
                                        "",
                                imageUrl:
                                    subActivitiesAdsVisible.first['image'] ??
                                        "",
                                arName:
                                    subActivitiesAdsVisible.first['ar_name'] ??
                                        "")
                            : CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 3),
                                  autoPlayAnimationDuration:
                                      const Duration(seconds: 3),
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enlargeCenterPage: true,
                                  enlargeFactor: 0.3,
                                  aspectRatio: 2052 / 1080,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                ),
                                items: subActivitiesAdsVisible.map((item) {
                                  return SubActivityAdsItem(
                                      action: item['action'] ?? "",
                                      url: item['url'] ?? "",
                                      subActivityObj: item,
                                      activityObj: item,
                                      collectionName:
                                          item['collection_name'] ?? "",
                                      adsCollectionName:
                                          item['ads_collection_name'] ?? "",
                                      enName: item['en_name'] ?? "",
                                      imageUrl: item['image'] ?? "",
                                      arName: item['ar_name'] ?? "");
                                }).toList(),
                              ),
                        SizedBox(
                          height: AppHeightSize.h2,
                        ),
                        DotIndicatorWidget(
                          currentIndex:
                              currentIndex, // Sync currentIndex with the carousel
                          count: subActivitiesAdsVisible.length,
                        ),
                      ],
                    ),
                  );
                },
              ),
              BlocConsumer<SubActivityCubit, SubActivityState>(
                listener: (context, state) {
                  if (state.status == CubitStatus.error) {
                    NoteMessage.showErrorSnackBar(
                        context: context, text: state.model.error ?? "");
                  }
                },
                builder: (context, state) {
                  if (state.status == CubitStatus.loading) {
                    return Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: AppHeightSize.h25),
                      child: AppCircularProgressIndicator(),
                    );
                  }

                  List<Map<String, dynamic>> subActivities =
                      (state.model.data?['sub_activities'] ?? [])
                          .cast<Map<String, dynamic>>();
                  List<Map<String, dynamic>> subActivitiesVisible =
                      subActivities
                          .where((element) => element['is_visible'] == true)
                          .toList();
                  if (subActivitiesVisible.isEmpty) {
                    return SizedBox(
                      height: AppHeightSize.h100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppText(
                            text: "thereAreNoDataToShow".tr(),
                            fontColor: AppColor.purple,
                            fontSize: AppFontSize.sp18,
                            fontWeight: FontWeight.w700,
                          ),
                          SizedBox(
                            height: AppHeightSize.h20,
                          ),
                          const ContactUsFooter()
                        ],
                      ),
                    );
                  }
                  return Column(
                    children: [
                      SubActivityList(
                        title: LanguageHelper.isEnglishAppLanguage()
                            ? "${widget.args.subActivityEnName} ${"list".tr()}"
                            : "${"list".tr()} ${widget.args.subActivityArName}",
                        collectionName: widget.args.collectionName,
                        subActivities: subActivitiesVisible,
                      ),
                      const ContactUsFooter()
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
