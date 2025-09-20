import 'package:easy_localization/easy_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntg_task/core/services/language_service.dart';
import 'package:ntg_task/core/widgets/arrow_widget.dart';

class ProductImageSection extends StatelessWidget {
  final dynamic product;
  const ProductImageSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    bool isArabic = LanguageService.isRTL(context.locale);
    return Container(
      height: 300.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(30.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: FancyShimmerImage(
                imageUrl: product.image ?? '',
                boxFit: BoxFit.contain,
              ),
            ),
          ),
          isArabic
              ? Positioned(top: 20.w, right: 20.w, child: const BackArrow())
              : Positioned(top: 20.w, left: 20.w, child: const BackArrow()),
          isArabic
              ? Positioned(
                top: 20.w,
                left: 20.w,
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              )
              : Positioned(
                top: 20.w,
                right: 20.w,
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
        ],
      ),
    );
  }
}
