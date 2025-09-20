import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import 'categories_shimmer.dart';
import '../cubit/home_cubit/cubit.dart';
import '../cubit/home_cubit/states.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        final isLoading = state is HomeLoading;
        final itemCount = isLoading ? 6 : cubit.categories.length;

        return SizedBox(
          height: 90.h,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: itemCount,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (_, index) => SizedBox(
              width: 80.w,
              child: isLoading
                  ? const CategoryShimmer()
                  : _BrandItem(title: cubit.categories[index]),
            ),
          ),
        );
      },
    );
  }
}

class _BrandItem extends StatelessWidget {
  final String title;
  const _BrandItem({required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundColor: Theme.of(context).colorScheme.background,
          child: const Icon(Icons.store, size: 30, color: AppColors.black),
        ),
        SizedBox(height: 6.h),
        Text(title,
          style: textTheme.bodySmall,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
