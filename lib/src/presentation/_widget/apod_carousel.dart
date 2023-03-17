import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../domain/entities/apod.dart';
import 'apod_carousel_item.dart';

class APODCarousel extends HookWidget {
  const APODCarousel({required this.apodList, super.key});

  final List<APOD> apodList;

  @override
  Widget build(BuildContext context) {
    final activeIndex = useState(0);

    final carouselController = useMemoized(CarouselController.new, []);

    return CarouselSlider.builder(
      itemCount: 5,
      carouselController: carouselController,
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: activeIndex.value,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) => activeIndex.value = index,
      ),
      itemBuilder: (context, index, realIndex) {
        if (apodList.isEmpty) {
          return const APODCarouselItem(apodData: APOD());
        }
        return APODCarouselItem(apodData: apodList[index]);
      },
    );
  }
}
