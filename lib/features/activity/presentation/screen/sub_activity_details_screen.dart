import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/firebase/firebase_core/firestore_method.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/helper/lanucher_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/storage/shared_pref/shared_preferences.dart';
import 'package:mo_wahaj_top/core/widget/image/app_cached_image.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/activity/presentation/cubit/add_favorite_cubit/add_favorite_cubit.dart';
import 'package:mo_wahaj_top/features/activity/presentation/cubit/add_favorite_cubit/add_favorite_state.dart';
import 'package:mo_wahaj_top/features/activity/presentation/screen/map_screen.dart';
import 'package:mo_wahaj_top/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:ui' as ui;
import '../../../../core/resource/cubit_status.dart';
import '../../../../core/widget/snack_bar/note_message.dart';
import 'booking_screen.dart';

/// Created by Eng.Eyad AlSayed on 5/28/2024.

class SubActivityDetailsArgs {
  Map<String, dynamic> activityDetails;
  String subActivityArName, subActivityEnName;
  String collectionName;

  SubActivityDetailsArgs(
      {required this.activityDetails,
      required this.subActivityArName,
      required this.subActivityEnName,
      required this.collectionName});
}

class SubActivityDetailsScreen extends StatefulWidget {
  const SubActivityDetailsScreen({super.key, required this.args});

  final SubActivityDetailsArgs args;

  @override
  State<SubActivityDetailsScreen> createState() =>
      _SubActivityDetailsScreenState();
}

class _SubActivityDetailsScreenState extends State<SubActivityDetailsScreen> {
  int selectedPage = 0;
  List<String> images = List.generate(5, (index) => 'null');
  Map<String, dynamic> contactInfo = {};
  bool isFavorite = false;

  @override
  void initState() {
    List<String> activityImages =
        (widget.args.activityDetails['images'] ?? []).cast<String>();

    FireStoreAddMethod.addActivityView(body: {
      'activity_name': widget.args.subActivityEnName,
      'image': activityImages.isNotEmpty ? activityImages.first : "",
      'in_view': true,
    });

    for (int i = 0; i < activityImages.length; i++) {
      images[i] = activityImages[i];
    }
    contactInfo = widget.args.activityDetails['contact_info'] ?? {};
    isFavorite = (widget.args.activityDetails['is_favorite_activity'] ?? false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    if (images[0].isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        height: AppHeightSize.h25,
                        child: AppCachedImage(
                          imageUrl: images[0],
                        ),
                      ),
                    Positioned(
                      top: 30,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.7),
                              radius: 15,
                              child: SvgPicture.asset(AppIcon.iosArrowLeft),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppHeightSize.h05),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppWidthSize.w5, right: AppWidthSize.w5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: LanguageHelper.isEnglishAppLanguage()
                            ? widget.args.subActivityEnName
                            : widget.args.subActivityArName,
                        fontSize: AppFontSize.sp16,
                        fontWeight: FontWeight.w600,
                      ),
                      if (AppSharedPreferences.isLogin() == true)
                        BlocConsumer<AddFavoriteCubit, AddFavoriteState>(
                          listener: (context, state) {
                            if (state.status == CubitStatus.error) {
                              NoteMessage.showErrorSnackBar(
                                  context: context,
                                  text: state.model.error ?? "");
                            }

                            if (state.status == CubitStatus.success) {
                              NoteMessage.showSuccessSnackBar(
                                  context: context,
                                  text: "sentSuccessfully".tr());
                            }
                          },
                          builder: (context, state) {
                            if (state.status == CubitStatus.loading) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppWidthSize.w3point8),
                                child: Center(
                                    child: SizedBox(
                                  width: AppWidthSize.w4,
                                  height: AppWidthSize.w4,
                                  child: AppCircularProgressIndicator(),
                                )),
                              );
                            }
                            return IconButton(
                              onPressed: () {
                                context
                                    .read<AddFavoriteCubit>()
                                    .addFavorite(body: {
                                  "collection_name": widget.args.collectionName,
                                  "sub_activity_details":
                                      widget.args.activityDetails,
                                  "en_sub_activity_name":
                                      widget.args.subActivityEnName,
                                  "ar_sub_activity_name":
                                      widget.args.subActivityArName,
                                  "is_favorite": !isFavorite,
                                });
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColor.purple,
                                size: 24.px,
                              ),
                            );
                          },
                        )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppWidthSize.w5, right: AppWidthSize.w5),
                  child: Container(
                    width: 38.px,
                    height: 19.px,
                    padding: EdgeInsets.only(
                        left: AppWidthSize.w1, right: AppWidthSize.w1),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColor.orange),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppText(
                          text: "4.5",
                          fontColor: AppColor.white,
                          fontSize: AppFontSize.sp12,
                          fontWeight: FontWeight.w500,
                        ),
                        SvgPicture.asset(AppIcon.star1)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppHeightSize.h2,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: AppWidthSize.w5, right: AppWidthSize.w5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.grey1,
                        borderRadius: BorderRadius.circular(15)),
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: AppColor.white,
                      indicator: BoxDecoration(
                          color: AppColor.purple,
                          borderRadius: BorderRadius.circular(15)),
                      unselectedLabelStyle: TextStyle(
                        fontFamily: GoogleFonts.ibmPlexSans()
                            .fontFamily, // Correctly access the fontFamily
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      labelStyle: TextStyle(
                        fontFamily: GoogleFonts.ibmPlexSans()
                            .fontFamily, // Correctly access the fontFamily
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      tabs: [
                        Tab(
                          text: 'overview'.tr(),
                        ),
                        Tab(
                          text: 'gallery'.tr(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppHeightSize.h2,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.only(
                      left: AppWidthSize.w5, right: AppWidthSize.w5),
                  child: TabBarView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 260,
                            padding: EdgeInsets.symmetric(
                                horizontal: AppWidthSize.w3point8,
                                vertical: AppHeightSize.h2),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.lightGrey,
                                      blurRadius: 15,
                                      offset: const Offset(1, 8))
                                ],
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.white),
                            child: Column(
                              children: [
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    tilePadding: EdgeInsets.zero,
                                    // Remove padding for the tile
                                    childrenPadding: EdgeInsets.zero,
                                    // Remove padding for children
                                    maintainState: true,
                                    title: AppText(
                                      text: "basicInfo".tr(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontColor: AppColor.navy,
                                    ),
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: AppWidthSize.w1),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    RouteName.map,
                                                    arguments: MapArgs(
                                                        subActivityName: LanguageHelper.isEnglishAppLanguage()
                                                            ? widget.args
                                                                .subActivityEnName
                                                            : widget.args
                                                                .subActivityArName,
                                                        subActivityImage:
                                                            images.first,
                                                        subActivityAddress:
                                                            LanguageHelper.isEnglishAppLanguage()
                                                                ? widget.args.activityDetails['en_address'] ??
                                                                    ""
                                                                : widget.args.activityDetails['ar_address'] ??
                                                                    "",
                                                        lat: widget.args.activityDetails[
                                                                'address_lat'] ??
                                                            0.0,
                                                        lon: widget.args.activityDetails['address_lon'] ?? 0.0));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        AppWidthSize.w3point8,
                                                    vertical: AppHeightSize.h2),
                                                // decoration: BoxDecoration(
                                                //     boxShadow: [
                                                //       BoxShadow(
                                                //           color: AppColor.lightGrey,
                                                //           blurRadius: 25,
                                                //           offset:
                                                //               const Offset(1, 9))
                                                //     ],
                                                //     borderRadius:
                                                //         BorderRadius.circular(10),
                                                //     color: AppColor.white),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppIcon.mapMarker,
                                                      colorFilter:
                                                          const ColorFilter
                                                              .mode(
                                                              AppColor.purple,
                                                              BlendMode.srcIn),
                                                    ),
                                                    SizedBox(
                                                      width: AppWidthSize.w1,
                                                    ),
                                                    Flexible(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: AppText(
                                                              text: LanguageHelper
                                                                      .isEnglishAppLanguage()
                                                                  ? widget.args
                                                                              .activityDetails[
                                                                          'en_address'] ??
                                                                      ""
                                                                  : widget.args
                                                                              .activityDetails[
                                                                          'ar_address'] ??
                                                                      "",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  AppFontSize
                                                                      .sp16,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  indent: 5,
                                  endIndent: 5,
                                  color: Color(0xffDDE5E9),
                                ),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                      dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    tilePadding: EdgeInsets.zero,
                                    // Remove padding for the tile
                                    childrenPadding: EdgeInsets.zero,
                                    // Remove padding for children
                                    maintainState: true,
                                    title: AppText(
                                      text: "contactInfo".tr(),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontColor: AppColor.navy,
                                    ),
                                    children: [
                                      Visibility(
                                        visible: showContactInfo() == true,
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    AppWidthSize.w3point8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Visibility(
                                                  visible: ((contactInfo[
                                                                  'cell_phone'] ??
                                                              "")
                                                          .toString())
                                                      .isNotEmpty,
                                                  child: InkWell(
                                                    onTap: () {
                                                      UrlLauncherHelper.makeCall(
                                                          image: images.first,
                                                          activityName: widget
                                                              .args
                                                              .subActivityEnName,
                                                          phoneNumber: contactInfo[
                                                                  'cell_phone'] ??
                                                              "");
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          AppIcon.call,
                                                          width:
                                                              AppWidthSize.w8,
                                                          height:
                                                              AppWidthSize.w8,
                                                          colorFilter:
                                                              const ColorFilter
                                                                  .mode(
                                                                  AppColor
                                                                      .purple,
                                                                  BlendMode
                                                                      .srcIn),
                                                        ),
                                                        // Directionality(
                                                        //   textDirection: ui
                                                        //       .TextDirection.ltr,
                                                        //   child: AppText(
                                                        //     text: contactInfo[
                                                        //             'cell_phone'] ??
                                                        //         "",
                                                        //     fontWeight:
                                                        //         FontWeight.w500,
                                                        //     fontSize:
                                                        //         AppFontSize.sp16,
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: ((contactInfo[
                                                                  'whatsapp'] ??
                                                              "")
                                                          .toString())
                                                      .isNotEmpty,
                                                  child: SizedBox(
                                                    height: AppHeightSize.h2,
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: ((contactInfo[
                                                                  'whatsapp'] ??
                                                              "")
                                                          .toString())
                                                      .isNotEmpty,
                                                  child: InkWell(
                                                    onTap: () {
                                                      UrlLauncherHelper.openWhatsapp(
                                                          activityName: widget
                                                              .args
                                                              .subActivityEnName,
                                                          image: images.first,
                                                          phoneNumber: contactInfo[
                                                                  'whatsapp'] ??
                                                              "");
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        // AppText(
                                                        //   text: contactInfo[
                                                        //           'whatsapp'] ??
                                                        //       "",
                                                        //   fontWeight:
                                                        //       FontWeight.w500,
                                                        //   fontSize:
                                                        //       AppFontSize.sp16,
                                                        // ),
                                                        SvgPicture.asset(
                                                          AppIcon.whatsLogo,
                                                          width:
                                                              AppWidthSize.w7,
                                                          height:
                                                              AppWidthSize.w7,
                                                          colorFilter:
                                                              const ColorFilter
                                                                  .mode(
                                                                  AppColor
                                                                      .purple,
                                                                  BlendMode
                                                                      .srcIn),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          AppText(
                            text: 'desc'.tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontColor: AppColor.navy,
                          ),
                          Expanded(
                            child: AppText(
                              text: LanguageHelper.isEnglishAppLanguage()
                                  ? widget.args.activityDetails['en_desc'] ?? ""
                                  : widget.args.activityDetails['ar_desc'] ??
                                      "",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          if (images[0].isNotEmpty)
                            Container(
                              width: AppWidthSize.w90,
                              height: AppHeightSize.h25,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.symmetric(
                                  horizontal: AppWidthSize.w2),
                              child: Stack(
                                children: [
                                  AppCachedImage(
                                    imageUrl: images[0],
                                  ),
                                  Positioned(
                                      child: Container(
                                    color: AppColor.black.withOpacity(0.1),
                                  )),
                                ],
                              ),
                            ),
                          SizedBox(
                            height: AppHeightSize.h2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (images[1].isNotEmpty)
                                Container(
                                  width: AppWidthSize.w41,
                                  height: AppHeightSize.h15,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: AppWidthSize.w2),
                                  child: Stack(
                                    children: [
                                      AppCachedImage(
                                        imageUrl: images[1],
                                      ),
                                      Positioned(
                                          child: Container(
                                        color: AppColor.black.withOpacity(0.1),
                                      )),
                                    ],
                                  ),
                                ),
                              if (images[2].isNotEmpty)
                                Container(
                                  width: AppWidthSize.w41,
                                  height: AppHeightSize.h15,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: AppWidthSize.w2),
                                  child: Stack(
                                    children: [
                                      AppCachedImage(
                                        imageUrl: images[2],
                                      ),
                                      Positioned(
                                          child: Container(
                                        color: AppColor.black.withOpacity(0.1),
                                      )),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: AppHeightSize.h1),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (images[3].isNotEmpty)
                                Container(
                                  width: AppWidthSize.w41,
                                  height: AppHeightSize.h15,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: AppWidthSize.w2),
                                  child: Stack(
                                    children: [
                                      AppCachedImage(
                                        imageUrl: images[3],
                                      ),
                                      Positioned(
                                          child: Container(
                                        color: AppColor.black.withOpacity(0.1),
                                      )),
                                    ],
                                  ),
                                ),
                              if (images[4].isNotEmpty)
                                Container(
                                  width: AppWidthSize.w41,
                                  height: AppHeightSize.h15,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: AppWidthSize.w2),
                                  child: Stack(
                                    children: [
                                      AppCachedImage(
                                        imageUrl: images[4],
                                      ),
                                      Positioned(
                                          child: Container(
                                        color: AppColor.black.withOpacity(0.1),
                                      )),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: AppSharedPreferences.isLogin() == true &&
                          widget.args.activityDetails['can_book'] ??
                      false,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(RouteName.booking,
                              arguments: BookingArgs(
                                collectionName: widget.args.collectionName,
                                subActivityEnName:
                                    widget.args.subActivityEnName,
                                subActivityArName:
                                    widget.args.subActivityArName,
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.purple,
                            padding: EdgeInsets.symmetric(
                                horizontal: AppWidthSize.w3point8,
                                vertical: AppHeightSize.h1point8),
                            textStyle: const TextStyle(color: Colors.white),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: AppHeightSize.h2,
                            ),
                            AppText(
                              text: "addBook".tr(),
                              fontSize: AppFontSize.sp15,
                              fontColor: AppColor.white,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: AppHeightSize.h2,
                            ),
                          ],
                        )),
                  ),
                ),
                Visibility(
                  visible: Platform.isIOS,
                  child: SizedBox(
                    height: AppHeightSize.h3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool showContactInfo() {
    String data = (contactInfo['cell_phone'] ?? "") +
        (contactInfo['whatsapp'] ?? "") +
        (contactInfo['telegram'] ?? "");

    return data.isNotEmpty;
  }
}

// desc

//location

//follow on:

//    Container(
//               margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AppText(
//                     text: "${"followOn".tr()} : ",
//                     fontWeight: FontWeight.w600,
//                     fontSize: AppFontSize.sp16,
//                   ),
//                   SizedBox(
//                     height: AppHeightSize.h2,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: AppWidthSize.w2,
//                       ),
//                       Visibility(
//                         visible: ((contactInfo['facebook'] ?? "").toString()).isNotEmpty,
//                         child: InkWell(
//                           onTap: () {
//                             UrlLauncherHelper.openFacebook(
//                                 activityName: widget.args.subActivityEnName,
//                                 image: images.first,
//                                 pageId: contactInfo['facebook'] ?? "");
//                           },
//                           child: SvgPicture.asset(
//                             AppIcon.faceBookCircle,
//                             width: AppWidthSize.w12,
//                             height: AppWidthSize.w12,
//                             colorFilter: const ColorFilter.mode(
//                                 AppColor.purple, BlendMode.srcIn),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: ((contactInfo['facebook'] ?? "").toString()).isNotEmpty,
//                         child: SizedBox(
//                           width: AppWidthSize.w2,
//                         ),
//                       ),
//                       Visibility(
//                           visible:
//                               ((contactInfo['instagram'] ?? "").toString()).isNotEmpty ||
//                                   true,
//                           child: SizedBox(
//                             width: AppWidthSize.w3,
//                           )),
//                       Visibility(
//                         visible: ((contactInfo['instagram'] ?? "").toString()).isNotEmpty,
//                         child: InkWell(
//                           onTap: () {
//                             UrlLauncherHelper.openInstagram(
//                                 activityName: widget.args.subActivityEnName,
//                                 image: images.first,
//                                 pageName: contactInfo['instagram'] ?? "");
//                           },
//                           child: SvgPicture.asset(
//                             AppIcon.instagram,
//                             width: AppWidthSize.w10,
//                             height: AppWidthSize.w10,
//                             colorFilter: const ColorFilter.mode(
//                                 AppColor.purple, BlendMode.srcIn),
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: ((contactInfo['website'] ?? "").toString())
//                             .isNotEmpty,
//                         child: SizedBox(
//                           height: AppHeightSize.h2,
//                         ),
//                       ),
//                       Visibility(
//                         visible: ((contactInfo['website'] ?? "").toString())
//                             .isNotEmpty,
//                         child: InkWell(
//                           onTap: () {
//                             List<String> activityImages =
//                                 (widget.args.activityDetails['images'] ?? [])
//                                     .cast<String>();
//
//                             FireStoreAddMethod.addActivityView(body: {
//                               'activity_name': widget.args.subActivityEnName,
//                               'image': activityImages.isNotEmpty
//                                   ? activityImages.first
//                                   : "",
//                               'website_action': true,
//                             });
//                             Navigator.pushNamed(context, RouteName.webView,
//                                 arguments: WebViewArgs(
//                                         url: contactInfo['website'] ?? "")
//                                     .toString());
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     width: AppWidthSize.w40,
//                                     child: AppText(
//                                       // text: contactInfo['website'] ?? "",
//                                       text: "Website",
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: AppFontSize.sp16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SvgPicture.asset(
//                                 AppIcon.website,
//                                 width: AppWidthSize.w7,
//                                 height: AppWidthSize.w7,
//                                 colorFilter: const ColorFilter.mode(
//                                     AppColor.purple, BlendMode.srcIn),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: ((contactInfo['snapchat'] ?? "").toString())
//                             .isNotEmpty,
//                         child: SizedBox(
//                           height: AppHeightSize.h2,
//                         ),
//                       ),
//                       Visibility(
//                         visible: ((contactInfo['snapchat'] ?? "").toString())
//                             .isNotEmpty,
//                         child: InkWell(
//                           onTap: () {
//                             UrlLauncherHelper.openSnapChat(
//                               url: contactInfo['snapchat'] ?? "",
//                               activityName: widget.args.subActivityEnName,
//                               image: images.first,
//                             );
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     width: AppWidthSize.w40,
//                                     child: AppText(
//                                       text: contactInfo['snapchat'] ?? "",
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: AppFontSize.sp16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SvgPicture.asset(
//                                 AppIcon.snapchat,
//                                 width: AppWidthSize.w7,
//                                 height: AppWidthSize.w7,
//                                 colorFilter: const ColorFilter.mode(
//                                     AppColor.purple, BlendMode.srcIn),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Visibility(
//                         visible: ((contactInfo['tiktok'] ?? "")).isNotEmpty,
//                         child: SizedBox(
//                           height: AppHeightSize.h2,
//                         ),
//                       ),
//                       Visibility(
//                         visible: ((contactInfo['tiktok'] ?? "").toString())
//                             .isNotEmpty,
//                         child: InkWell(
//                           onTap: () {
//                             UrlLauncherHelper.openTiktok(
//                               url: contactInfo['tiktok'] ?? "",
//                               activityName: widget.args.subActivityEnName,
//                               image: images.first,
//                             );
//                           },
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     width: AppWidthSize.w40,
//                                     child: AppText(
//                                       text: contactInfo['tiktok'] ?? "",
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: AppFontSize.sp16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SvgPicture.asset(
//                                 AppIcon.tiktok,
//                                 width: AppWidthSize.w7,
//                                 height: AppWidthSize.w7,
//                                 colorFilter: const ColorFilter.mode(
//                                     AppColor.purple, BlendMode.srcIn),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//Contact Info:
