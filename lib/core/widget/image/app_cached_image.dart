import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mo_wahaj_top/core/resource/app_color.dart';
import 'package:mo_wahaj_top/core/resource/app_size.dart';

import '../loader/app_circular_progress_indicator.dart';

/**
 * Created by Eng.Eyad AlSayed on 5/14/2024.
 */

class AppCachedImage extends StatelessWidget {
  const AppCachedImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Center(child: AppCircularProgressIndicator()),
      errorWidget: (context, url, error) => const Center(
        child: Icon(
          Icons.error,
          color: AppColor.red,
        ),
      ),
    );
  }
}
