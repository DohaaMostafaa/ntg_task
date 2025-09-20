import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntg_task/core/helpers/spacing_helper.dart';
import 'package:ntg_task/core/localization/locale_keys.g.dart';
import 'package:ntg_task/core/theme/app_colors.dart';


class ProductDetailsSection extends StatelessWidget {
  final dynamic product;
  const ProductDetailsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: ListView(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.title ?? '',
                  style: textTheme.bodyLarge?.copyWith(fontSize: 18.sp),
                ),
              ),
              Text(
                "\$${product.price ?? 0}",
                style: textTheme.titleLarge?.copyWith(fontSize: 20.sp),
              ),
            ],
          ),
          verticalSpace(10.h),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber.shade600, size: 20),
              horizontalSpace(4.w),
              Text(
                "${product.rating?.rate ?? 0} (${product.rating?.count ?? 0} ${LocaleKeys.reviews.tr()})",
                style: const TextStyle(color: AppColors.grey),
              ),
            ],
          ),
          verticalSpace(20.h),
          Text(LocaleKeys.description.tr(), style: textTheme.bodyLarge),
          verticalSpace(8.h),
          Text(
            product.description ?? '',
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
