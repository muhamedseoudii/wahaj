import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

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
