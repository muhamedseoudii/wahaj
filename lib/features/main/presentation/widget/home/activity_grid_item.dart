import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mo_wahaj_top/core/helper/language_helper.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';
import 'package:mo_wahaj_top/core/widget/image/app_cached_image.dart';
import 'package:mo_wahaj_top/core/widget/text/app_text.dart';

import '../../../../../core/firebase/firebase_core/firestore_method.dart';
import '../../../../../core/resource/app_color.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/11/2024.
 */

class ActivityItem extends StatefulWidget {
  const ActivityItem({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<ActivityItem> createState() => _ActivityItemState();
}

class _ActivityItemState extends State<ActivityItem> {
  @override
  void initState() {
    FireStoreAddMethod.addActivityView(body: {
      'activity_name': widget.data['en_name'] ?? "",
      'image': widget.data['image'] ?? "",
      'out_view': true,
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          width: AppWidthSize.w20,
          height: AppWidthSize.w20,
          child: AppCachedImage(
            imageUrl: widget.data['image'] ?? "",
          ),
        ),
        SizedBox(
          height: AppHeightSize.h2,
        ),
        AppText(
          text: LanguageHelper.isEnglishAppLanguage()
              ? widget.data['en_name'] ?? ""
              : widget.data['ar_name'] ?? "",
          maxLines: 2,
          fontColor: Colors.black,
          fontSize: AppFontSize.sp15,
        )
      ],
    );
  }
}
