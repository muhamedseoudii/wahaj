import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/widget/button/login_button.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../../../../core/firebase/firebase_core/firestore_method.dart';
import '../../../../../core/resource/app_color.dart';
import '../../../../../core/resource/app_size.dart';
import '../../../../../core/widget/image/app_cached_image.dart';
import '../../../../../core/widget/text/app_text.dart';
import '../../../../activity/presentation/screen/sub_activity_details_screen.dart';
import '../../../../activity/presentation/screen/sub_activity_screen.dart';
import '../../../../web_view/presentation/screen/web_view_screen.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/28/2024.
 */

class AdsList extends StatelessWidget {
  const AdsList({super.key, required this.adData});

  final List<Map<String, dynamic>> adData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppHeightSize.h20,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            String imageUrl = adData[index]['image'] ?? "";
            return Visibility(
              visible: adData[index]['is_visible'] ?? false,
              child: LoginButton(
                onTap: () {
                  String action = adData[index]['action'] ?? "";
                  String url = adData[index]['url'] ?? "";
                  if (action == 'open_url') {
                    Navigator.pushNamed(context, RouteName.webView,
                        arguments: WebViewArgs(url: url));
                  } else if (action == 'open_contact_us') {
                    Navigator.pushNamed(context, RouteName.contactUs);
                  } else if (action == 'open_category') {
                    Navigator.pushNamed(context, RouteName.subActivity,
                        arguments: SubActivityArgs(
                            subActivityArName: adData[index]['ar_name'] ?? "",
                            subActivityEnName: adData[index]['en_name'] ?? "",
                            adsCollectionName:
                                adData[index]['ads_collection_name'] ?? "",
                            collectionName:
                                adData[index]['collection_name'] ?? ""));
                  } else if (action == 'open_sub_activity') {
                    Navigator.of(context).pushNamed(
                        RouteName.subActivityDetails,
                        arguments: SubActivityDetailsArgs(
                            collectionName:
                                adData[index]['collection_name'] ?? "",
                            subActivityEnName: adData[index]['en_name'] ?? "",
                            subActivityArName: adData[index]['ar_name'] ?? "",
                            activityDetails:
                                adData[index]['activity_details'] ?? {}));
                  }
                },
                child: AdsListItem(
                  imageUrl: imageUrl,
                  enName: adData[index]['en_name'] ?? "",
                  arName: adData[index]['ar_name'] ?? "",
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: AppWidthSize.w2,
              ),
          itemCount: adData.length),
    );
  }
}

class AdsListItem extends StatefulWidget {
  const AdsListItem(
      {super.key,
      required this.imageUrl,
      required this.arName,
      required this.enName});

  final String imageUrl;
  final String enName, arName;

  @override
  State<AdsListItem> createState() => _AdsListItemState();
}

class _AdsListItemState extends State<AdsListItem> {
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
      width: AppWidthSize.w90,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
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
                fontSize: AppFontSize.sp18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
