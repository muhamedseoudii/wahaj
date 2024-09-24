import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/button/login_button.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/home/activity_grid_item.dart';
import 'package:mo_wahaj_top/features/main/presentation/widget/home/most_banner_widget.dart';
import 'package:mo_wahaj_top/router/app_router.dart';

import '../../../../activity/presentation/screen/sub_activity_details_screen.dart';
import '../../../../activity/presentation/screen/sub_activity_screen.dart';
import '../../../../web_view/presentation/screen/web_view_screen.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class ActivityList extends StatelessWidget {
  const ActivityList({super.key, required this.data, required this.title});

  final List<Map<String, dynamic>> data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MostBannerWidget(
          title: "mostPopular",
          title1: "seeAll",
          onTap: () {},
        ),
        // AppText(
        //   text: title,
        //   fontWeight: FontWeight.bold,
        //   fontSize: AppFontSize.sp16,
        // ),
        SizedBox(
          height: AppHeightSize.h2,
        ),
        SizedBox(
          width: double.infinity,
          height: 110,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Visibility(
                  visible: data[index]['is_visible'] ?? false,
                  child: LoginButton(
                    onTap: () {
                      String action = data[index]['action'] ?? "";
                      String url = data[index]['url'] ?? "";

                      if (action == 'open_url') {
                        Navigator.pushNamed(context, RouteName.webView,
                            arguments: WebViewArgs(url: url));
                      } else if (action == 'open_contact_us') {
                        Navigator.pushNamed(context, RouteName.contactUs);
                      } else if (action == 'open_category') {
                        Navigator.pushNamed(context, RouteName.subActivity,
                            arguments: SubActivityArgs(
                                subActivityArName: data[index]['ar_name'] ?? "",
                                subActivityEnName: data[index]['en_name'] ?? "",
                                adsCollectionName:
                                    data[index]['ads_collection_name'] ?? "",
                                collectionName:
                                    data[index]['collection_name'] ?? ""));
                      } else if (action == 'open_sub_activity') {
                        Navigator.of(context).pushNamed(
                            RouteName.subActivityDetails,
                            arguments: SubActivityDetailsArgs(
                                collectionName:
                                    data[index]['collection_name'] ?? "",
                                subActivityEnName: data[index]['en_name'] ?? "",
                                subActivityArName: data[index]['ar_name'] ?? "",
                                activityDetails:
                                    data[index]['activity_details'] ?? {}));
                      }
                    },
                    child: ActivityItem(
                      data: data[index],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: AppWidthSize.w3,
                  ),
              itemCount: data.length),
        ),
      ],
    );
  }
}
