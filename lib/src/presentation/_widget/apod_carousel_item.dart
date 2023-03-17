import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/apod.dart';

class APODCarouselItem extends StatelessWidget {
  const APODCarouselItem({required this.apodData, super.key});
  final APOD apodData;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.sp),
      child: Container(
        width: 550.w,
        color: Colors.red,
        child: (apodData.hdurl == null)
            ? const CircularProgressIndicator.adaptive()
            : Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: apodData.hdurl!,
                    placeholder: (_, url) =>
                        const CircularProgressIndicator.adaptive(),
                    errorWidget: (_, str, url) =>
                        const CircularProgressIndicator.adaptive(),
                    fit: BoxFit.cover,
                    height: 100.sh,
                    width: 550.w,
                  )
                ],
              ),
      ),
    );
  }
}
