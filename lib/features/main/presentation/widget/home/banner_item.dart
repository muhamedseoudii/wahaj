import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/widget/button/login_button.dart';
import 'package:mo_wahaj_top/features/web_view/presentation/screen/web_view_screen.dart';
import '../../../../../core/firebase/firebase_core/firestore_method.dart';
import '../../../../../core/widget/image/app_cached_image.dart';
import '../../../../../router/app_router.dart';
import '../../../../activity/presentation/screen/sub_activity_details_screen.dart';
import '../../../../activity/presentation/screen/sub_activity_screen.dart';

class BannerItem extends StatefulWidget {
  const BannerItem(
      {super.key,
      required this.image,
      required this.enName,
      required this.subActivityObj,
      required this.url,
      required this.action,
      required this.activityObj});

  final String image, enName;
  final String action, url;
  final Map<String, dynamic> activityObj, subActivityObj;
  @override
  State<BannerItem> createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> {
  static final Map<String, bool> isAddedView = {};

  @override
  void initState() {
    if ((isAddedView[widget.enName] ?? false) == false) {
      FireStoreAddMethod.addActivityView(body: {
        'activity_name': widget.enName,
        'image': widget.image,
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
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: AppCachedImage(
            imageUrl: widget.image,
          )),
    );
  }
}
