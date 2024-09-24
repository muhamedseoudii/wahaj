import 'package:flutter/cupertino.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/widget/button/login_button.dart';
import '../../../../core/firebase/firebase_core/firestore_method.dart';
import '../../../../core/helper/language_helper.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../core/widget/image/app_cached_image.dart';
import '../../../../core/widget/text/app_text.dart';
import '../../../../router/app_router.dart';
import '../../../web_view/presentation/screen/web_view_screen.dart';
import '../screen/sub_activity_details_screen.dart';
import '../screen/sub_activity_screen.dart';

class SubActivityAdsItem extends StatefulWidget {
  const SubActivityAdsItem(
      {super.key,
      required this.enName,
      required this.collectionName,
      required this.adsCollectionName,
      required this.imageUrl,
      required this.arName,
      required this.subActivityObj,
      required this.url,
      required this.action,
      required this.activityObj});

  final String imageUrl, arName, enName, collectionName, adsCollectionName;
  final String action, url;
  final Map<String, dynamic> activityObj, subActivityObj;
  @override
  State<SubActivityAdsItem> createState() => _SubActivityAdsItemState();
}

class _SubActivityAdsItemState extends State<SubActivityAdsItem> {
  static final Map<String, bool> isAddedView = {};

  @override
  void initState() {
    if ((isAddedView[widget.enName] ?? false) == false) {
      FireStoreAddMethod.addActivityView(body: {
        'activity_name': widget.enName,
        'image': widget.imageUrl,
        'out_view': true,
      });
      isAddedView[widget.enName] = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginButton(
      onTap: () {
        if (widget.action == 'open_url') {
          Navigator.pushNamed(context, RouteName.webView,
              arguments: WebViewArgs(url: widget.url));
        } else if (widget.action == 'open_contact_us') {
          Navigator.pushNamed(context, RouteName.contactUs);
        } else if (widget.action == 'open_category') {
          Navigator.pushNamed(context, RouteName.subActivity,
              arguments: SubActivityArgs(
                  subActivityArName: widget.activityObj['ar_name'] ?? "",
                  subActivityEnName: widget.activityObj['en_name'] ?? "",
                  adsCollectionName:
                      widget.activityObj['ads_collection_name'] ?? "",
                  collectionName: widget.activityObj['collection_name'] ?? ""));
        } else if (widget.action == 'open_sub_activity') {
          Navigator.of(context).pushNamed(RouteName.subActivityDetails,
              arguments: SubActivityDetailsArgs(
                  collectionName:
                      widget.subActivityObj['collection_name'] ?? "",
                  subActivityEnName: widget.subActivityObj['en_name'] ?? "",
                  subActivityArName: widget.subActivityObj['ar_name'] ?? "",
                  activityDetails:
                      widget.subActivityObj['activity_details'] ?? {}));
        }
      },
      child: Container(
        width: AppWidthSize.w90,
        height: AppHeightSize.h25,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: AppWidthSize.w2),
        child: Stack(
          children: [
            AppCachedImage(
              imageUrl: widget.imageUrl,
            ),
            Positioned(
                child: Container(
              color: AppColor.black.withOpacity(0.1),
            )),
            Padding(
              padding: EdgeInsets.only(
                  right: AppWidthSize.w3,
                  left: AppWidthSize.w3,
                  bottom: AppHeightSize.h2),
              child: Align(
                alignment: LanguageHelper.isEnglishAppLanguage()
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
                child: AppText(
                  text: LanguageHelper.isEnglishAppLanguage()
                      ? widget.enName
                      : widget.arName,
                  fontColor: AppColor.white,
                  fontSize: AppFontSize.sp18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
