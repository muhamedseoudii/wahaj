import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/snack_bar/note_message.dart';
import 'package:mo_wahaj_top/features/account/cubit/favorite_cubit/favorite_cubit.dart';
import 'package:mo_wahaj_top/features/account/presentation/widget/favorite_list_item.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/widget/text/app_text.dart';
import '../../../../router/app_router.dart';
import '../../../activity/presentation/screen/sub_activity_details_screen.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          surfaceTintColor: AppColor.white,
          backgroundColor: AppColor.white,
          title: AppText(
            text: "favorite_list".tr(),
            fontSize: AppFontSize.sp20,
            fontWeight: FontWeight.w400,
            fontColor: AppColor.navy,
          ),
        ),
        body: BlocConsumer<FavoriteCubit, FavoriteState>(
          listener: (context, state) {
            if (state.status == CubitStatus.error) {
              NoteMessage.showErrorSnackBar(
                  context: context, text: state.model.error ?? "");
            }
          },
          builder: (context, state) {
            if (state.status == CubitStatus.loading) {
              return Center(
                child: AppCircularProgressIndicator(),
              );
            }

            List<Map<String, dynamic>> favoriteList =
                (state.model.data?['favorites'] ?? [])
                    .cast<Map<String, dynamic>>();

            if (favoriteList.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite,
                      size: 40.px,
                      color: AppColor.purple,
                    ),
                    SizedBox(
                      height: AppHeightSize.h2,
                    ),
                    AppText(
                      text: "emptyFavorite".tr(),
                      fontSize: AppFontSize.sp17,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColor.purple,
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: AppWidthSize.w5,
                      left: AppWidthSize.w5,
                      right: AppWidthSize.w5),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColor.white,
                    indicator: BoxDecoration(
                        color: AppColor.purple,
                        borderRadius: BorderRadius.circular(5)),
                    unselectedLabelStyle: TextStyle(
                      fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    labelStyle: TextStyle(
                      fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: [
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.fromBorderSide(BorderSide(
                              color: AppColor.purple,
                            ))),
                        child: Tab(
                          text: 'newplaces'.tr(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.fromBorderSide(BorderSide(
                              color: AppColor.purple,
                            ))),
                        child: Tab(
                          text: 'offers'.tr(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppHeightSize.h2,
                                  horizontal: AppWidthSize.w3),
                              child: ListView.separated(
                                  padding:
                                      EdgeInsets.only(bottom: AppHeightSize.h2),
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          Navigator.of(context).pushNamed(
                                              RouteName.subActivityDetails,
                                              arguments: SubActivityDetailsArgs(
                                                  collectionName: favoriteList[index]
                                                          ['collection_name'] ??
                                                      "",
                                                  subActivityEnName:
                                                      favoriteList[index][
                                                              'en_sub_activity_name'] ??
                                                          "",
                                                  subActivityArName:
                                                      favoriteList[index][
                                                              'ar_sub_activity_name'] ??
                                                          "",
                                                  activityDetails: favoriteList[index]
                                                          ['sub_activity_details'] ??
                                                      {}));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: AppWidthSize.w3,
                                              right: AppWidthSize.w3),
                                          child: FavoriteListItem(
                                              address: LanguageHelper.isEnglishAppLanguage()
                                                  ? favoriteList[index]['sub_activity_details']
                                                          ['en_address'] ??
                                                      ""
                                                  : favoriteList[index]
                                                              ['sub_activity_details']
                                                          ['ar_address'] ??
                                                      "",
                                              name: LanguageHelper.isEnglishAppLanguage()
                                                  ? favoriteList[index]['en_sub_activity_name'] ??
                                                      ""
                                                  : favoriteList[index][
                                                          'ar_sub_activity_name'] ??
                                                      "",
                                              image: favoriteList[index]
                                                          ['sub_activity_details']
                                                      ['images'][0] ??
                                                  ""),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: AppHeightSize.h2,
                                      ),
                                  itemCount: favoriteList.length),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            size: 40.px,
                            color: AppColor.purple,
                          ),
                          SizedBox(
                            height: AppHeightSize.h2,
                          ),
                          AppText(
                            text: "emptyFavorite".tr(),
                            fontSize: AppFontSize.sp17,
                            fontWeight: FontWeight.w600,
                            fontColor: AppColor.purple,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
