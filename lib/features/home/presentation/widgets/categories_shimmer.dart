import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/base_shimmer.dart';

class CategoryShimmer extends BaseShimmer {
  const CategoryShimmer({super.key});

  @override
  Widget buildShimmer(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 28.r, backgroundColor: AppColors.lightGrey),
        SizedBox(height: 6.h),
        Container(
          width: 60.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
      ],
    );
  }
}
