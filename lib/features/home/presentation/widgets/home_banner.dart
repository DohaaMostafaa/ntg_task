import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/assets/app_assets.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      AppAssets.banner1,
      AppAssets.banner2,
      AppAssets.banner3,
    ];

    return SizedBox(
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 120.h,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1.0,
          aspectRatio: 16 / 9,
        ),
        items: imgList.map((item) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          );
        }).toList(),
      ),
    );
  }
}
