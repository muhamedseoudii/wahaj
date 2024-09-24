import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/button/login_button.dart';
import 'package:mo_wahaj_top/core/widget/image/app_cached_image.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/router/app_router.dart';
import '../../../../../core/firebase/firebase_core/firestore_method.dart';
import '../../../../../core/resource/app_color.dart';
import '../../../../activity/presentation/screen/sub_activity_details_screen.dart';
import '../../../../activity/presentation/screen/sub_activity_screen.dart';
import '../../../../web_view/presentation/screen/web_view_screen.dart';

class OtherActivityList extends StatelessWidget {
  const OtherActivityList(
      {super.key, required this.activityData, required this.title});
  final List<Map<String, dynamic>> activityData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthSize.w3point8),
          child: AppText(
            text: title,
            fontSize: AppFontSize.sp16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: AppHeightSize.h1,
        ),
        SizedBox(
          height: AppHeightSize.h15,
          child: ListView.separated(
              padding: EdgeInsets.only(
                  right: AppWidthSize.w4, left: AppWidthSize.w3point8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String imageUrl = activityData[index]['image'] ?? "";

                return Visibility(
                  visible: activityData[index]['is_visible'] ?? false,
                  child: LoginButton(
                    onTap: () {
                      String action = activityData[index]['action'] ?? "";
                      String url = activityData[index]['url'] ?? "";
                      if (action == 'open_url') {
                        Navigator.pushNamed(context, RouteName.webView,
                            arguments: WebViewArgs(url: url));
                      } else if (action == 'open_contact_us') {
                        Navigator.pushNamed(context, RouteName.contactUs);
                      } else if (action == 'open_category') {
                        Navigator.pushNamed(context, RouteName.subActivity,
                            arguments: SubActivityArgs(
                                subActivityArName:
                                    activityData[index]['ar_name'] ?? "",
                                subActivityEnName:
                                    activityData[index]['en_name'] ?? "",
                                adsCollectionName: activityData[index]
                                        ['ads_collection_name'] ??
                                    "",
                                collectionName: activityData[index]
                                        ['collection_name'] ??
                                    ""));
                      } else if (action == 'open_sub_activity') {
                        Navigator.of(context).pushNamed(
                            RouteName.subActivityDetails,
                            arguments: SubActivityDetailsArgs(
                                collectionName: activityData[index]
                                        ['collection_name'] ??
                                    "",
                                subActivityEnName:
                                    activityData[index]['en_name'] ?? "",
                                subActivityArName:
                                    activityData[index]['ar_name'] ?? "",
                                activityDetails: activityData[index]
                                        ['activity_details'] ??
                                    {}));
                      }
                    },
                    child: OtherActivityItem(
                      imageUrl: imageUrl,
                      enName: activityData[index]['en_name'] ?? "",
                      arName: activityData[index]['ar_name'] ?? "",
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: AppWidthSize.w1,
                  ),
              itemCount: activityData.length),
        ),
      ],
    );
  }
}

class OtherActivityItem extends StatefulWidget {
  const OtherActivityItem(
      {super.key,
      required this.imageUrl,
      required this.enName,
      required this.arName});
  final String imageUrl, enName, arName;

  @override
  State<OtherActivityItem> createState() => _OtherActivityItemState();
}

class _OtherActivityItemState extends State<OtherActivityItem> {
  @override
  void initState() {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': widget.enName,
      'image': widget.imageUrl,
      'out_view': true,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppWidthSize.w50,
      height: AppHeightSize.h15,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          AppCachedImage(
            imageUrl: widget.imageUrl,
          ),
          Positioned(
              child: Container(
            color: (LanguageHelper.isEnglishAppLanguage()
                        ? widget.enName
                        : widget.arName)
                    .isEmpty
                ? Colors.transparent
                : AppColor.black.withOpacity(0.2),
          )),
          Padding(
            padding: EdgeInsets.only(
                right: AppWidthSize.w3, bottom: AppHeightSize.h2),
            child: Align(
              alignment: Alignment.bottomRight,
              child: AppText(
                text: LanguageHelper.isEnglishAppLanguage()
                    ? widget.enName
                    : widget.arName,
                fontColor: Colors.white,
                fontSize: AppFontSize.sp15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
