import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_icon.dart';
import 'package:mo_wahaj_top/core/resource/cubit_status.dart';
import 'package:mo_wahaj_top/core/widget/footer/main_app_footer.dart';
import 'package:mo_wahaj_top/core/widget/loader/app_circular_progress_indicator.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/account/cubit/places_cubit/places_cubit.dart';
import 'package:mo_wahaj_top/features/account/presentation/screen/places_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/image/app_cached_image.dart';
import '../../../../core/widget/snack_bar/note_message.dart';

/// Created by Eng.Eyad AlSayed on 5/12/2024.

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  int showedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        title: AppText(
          text: "places".tr(),
          fontSize: AppFontSize.sp18,
          fontWeight: FontWeight.w500,
          fontColor: AppColor.navy,
        ),
      ),
      body: BlocConsumer<PlacesCubit, PlacesState>(
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

          List<Map<String, dynamic>> data =
              (state.model.data?['places'] ?? []).cast<Map<String, dynamic>>();

          if (data.isEmpty) {
            return Center(child: AppText(text: "thereIsNoPlacesToShow".tr()));
          }

          return Column(
            children: [
              Flexible(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    var item = data[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaceDetailScreen(
                              imageUrl: item['image'] ?? "",
                              name: LanguageHelper.isEnglishAppLanguage()
                                  ? item['en_name'] ?? ""
                                  : item['ar_name'] ?? "",
                              description: LanguageHelper.isEnglishAppLanguage()
                                  ? item['en_description'] ?? ""
                                  : item['ar_description'] ?? "",
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppWidthSize.w4,
                          vertical: AppHeightSize.h2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(28, 130, 130, 130),
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(3, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Image section
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 84.px,
                                  width: 84.px,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: AppCachedImage(
                                    imageUrl: item['image'] ?? "",
                                  ),
                                ),
                                SizedBox(width: AppWidthSize.w3point8),

                                // Text details section
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment:
                                          LanguageHelper.isEnglishAppLanguage()
                                              ? Alignment.bottomLeft
                                              : Alignment.bottomRight,
                                      child: AppText(
                                        text: LanguageHelper
                                                .isEnglishAppLanguage()
                                            ? item['en_name'] ?? ""
                                            : item['ar_name'] ?? "",
                                        fontColor: AppColor.navy,
                                        fontSize: AppFontSize.sp16,
                                      ),
                                    ),
                                    SizedBox(height: AppHeightSize.h05),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppIcon.mapMarker,
                                          width: AppWidthSize.w5,
                                          height: AppWidthSize.w5,
                                          colorFilter: const ColorFilter.mode(
                                              AppColor.purple, BlendMode.srcIn),
                                        ),
                                        SizedBox(
                                          width: AppWidthSize.w2,
                                        ),
                                        AppText(
                                          fontColor: Colors.black,
                                          maxLines: 1,
                                          textOverflow: TextOverflow.ellipsis,
                                          fontSize: AppFontSize.sp15,
                                          text: LanguageHelper
                                                  .isEnglishAppLanguage()
                                              ? item['en_address'] ?? ""
                                              : item['ar_address'] ?? "",
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            // const Align(
                            //   alignment: Alignment.bottomCenter,
                            //   child: MainAppFooter(),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: AppHeightSize.h1,
                  ),
                  itemCount: data.length,
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: MainAppFooter(),
              ),
            ],
          );
        },
      ),
    );
  }
}
// class PlacesScreen extends StatefulWidget {
//   const PlacesScreen({super.key});
//
//   @override
//   State<PlacesScreen> createState() => _PlacesScreenState();
// }
//
// class _PlacesScreenState extends State<PlacesScreen> {
//   int showedIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.background,
//       appBar: AppBar(
//         backgroundColor: AppColor.white,
//         surfaceTintColor: AppColor.white,
//       ),
//       body: BlocConsumer<PlacesCubit, PlacesState>(
//         listener: (context, state) {
//           if (state.status == CubitStatus.error) {
//             NoteMessage.showErrorSnackBar(
//                 context: context, text: state.model.error ?? "");
//           }
//         },
//         builder: (context, state) {
//           if (state.status == CubitStatus.loading) {
//             return Center(
//               child: AppCircularProgressIndicator(),
//             );
//           }
//
//           List<Map<String, dynamic>> data =
//               (state.model.data?['places'] ?? []).cast<Map<String, dynamic>>();
//
//           if (data.isEmpty) {
//             return Center(child: AppText(text: "thereIsNoPlacesToShow".tr()));
//           }
//           return Column(
//             children: [
//               SizedBox(
//                 height: AppHeightSize.h2,
//               ),
//               Expanded(
//                 child: ListView(
//                   children: [
//                     CarouselSlider(
//                       options: CarouselOptions(
//                           onPageChanged: (index, reason) {
//                             setState(() {
//                               showedIndex = index;
//                             });
//                           },
//                           autoPlay: true,
//                           autoPlayInterval: const Duration(seconds: 3),
//                           autoPlayAnimationDuration: const Duration(seconds: 3),
//                           autoPlayCurve: Curves.fastOutSlowIn,
//                           enlargeCenterPage: true,
//                           enlargeFactor: 0.3,
//                           aspectRatio: 2052 / 1080),
//                       items: data.map((item) {
//                         return Container(
//                           clipBehavior: Clip.antiAliasWithSaveLayer,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15)),
//                           width: double.infinity,
//                           height: AppHeightSize.h25,
//                           child: Stack(
//                             children: [
//                               AppCachedImage(imageUrl: item['image'] ?? ""),
//                               Positioned(
//                                   child: Container(
//                                 color: AppColor.black.withOpacity(0.2),
//                               )),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     right: AppWidthSize.w3,
//                                     left: AppWidthSize.w3,
//                                     bottom: AppHeightSize.h2),
//                                 child: Align(
//                                   alignment:
//                                       LanguageHelper.isEnglishAppLanguage()
//                                           ? Alignment.bottomLeft
//                                           : Alignment.bottomRight,
//                                   child: AppText(
//                                     text: LanguageHelper.isEnglishAppLanguage()
//                                         ? item['en_name'] ?? ""
//                                         : item['ar_name'] ?? "",
//                                     fontColor: Colors.white,
//                                     fontSize: AppFontSize.sp18,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                     SizedBox(
//                       height: AppHeightSize.h3,
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                           horizontal: AppWidthSize.w3point8),
//                       child: AnimatedSwitcher(
//                           duration: const Duration(milliseconds: 100),
//                           transitionBuilder:
//                               (Widget child, Animation<double> animation) {
//                             return FadeTransition(
//                                 opacity: animation, child: child);
//                           },
//                           child: Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Flexible(
//                                     child: AppText(
//                                         height: 2.0,
//                                         fontSize: AppFontSize.sp15,
//                                         text: LanguageHelper
//                                                 .isEnglishAppLanguage()
//                                             ? data[showedIndex]
//                                                     ['en_description'] ??
//                                                 ""
//                                             : data[showedIndex]
//                                                     ['ar_description'] ??
//                                                 ""),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: AppHeightSize.h3,
//                               )
//                             ],
//                           )),
//                     ),
//                   ],
//                 ),
//               ),
//               const Align(
//                   alignment: Alignment.bottomCenter, child: MainAppFooter()),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
