import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';
import 'package:mo_wahaj_top/features/activity/presentation/cubit/sub_activity_cubit/sub_activity_cubit.dart';
import 'package:mo_wahaj_top/features/activity/presentation/widget/sub_activity_item.dart';

import '../../../../core/helper/language_helper.dart';
import '../../../../core/resource/app_size.dart';
import '../../../../router/app_router.dart';
import '../screen/sub_activity_details_screen.dart';

/**
 * Created by Eng.Eyad AlSayed on 6/22/2024.
 */

class SubActivityList extends StatelessWidget {
  const SubActivityList(
      {super.key,
      required this.title,
      required this.collectionName,
      required this.subActivities});

  final String collectionName;
  final String title;
  final List<Map<String, dynamic>> subActivities;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppWidthSize.w3point8, vertical: AppHeightSize.h2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: title,
              fontSize: AppFontSize.sp18,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: AppHeightSize.h2,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subActivities.length,
              itemBuilder: (context, index) {
                return SubActivityItem(
                  arAddress: subActivities[index]['activity_details']
                          ['ar_address'] ??
                      "",
                  enAddress: subActivities[index]['activity_details']
                          ['en_address'] ??
                      "",
                  imageUrl: subActivities[index]['image'] ?? "",
                  arName: subActivities[index]['ar_name'] ?? "",
                  enName: subActivities[index]['en_name'] ?? "",
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        RouteName.subActivityDetails,
                        arguments: SubActivityDetailsArgs(
                            collectionName: collectionName,
                            subActivityEnName:
                                subActivities[index]['en_name'] ?? "",
                            subActivityArName:
                                subActivities[index]['ar_name'] ?? "",
                            activityDetails: subActivities[index]
                                    ['activity_details'] ??
                                {}));
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: AppHeightSize.h5,
              ),
            ),
          ],
        ));
  }
}
