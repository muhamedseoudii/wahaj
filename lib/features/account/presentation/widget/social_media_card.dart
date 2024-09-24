import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/resource/app_color.dart';
import '../../../../core/resource/app_size.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/14/2024.
 */

class SocialMediaCard extends StatelessWidget {
  const SocialMediaCard({super.key, required this.icon, required this.url});

  final String icon, url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await launchUrl(Uri.parse(url)).catchError((error) {
          return error;
        });
      },
      child: SvgPicture.asset(
        icon,
      ),
    );
  }
}
