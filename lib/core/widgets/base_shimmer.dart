import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';

abstract class BaseShimmer extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;

  const BaseShimmer({
    super.key,
    this.baseColor,
    this.highlightColor = AppColors.white,
  });

  Widget buildShimmer(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveBaseColor = baseColor ??
        (isDark ? AppColors.grey : AppColors.lightGrey);

    return Shimmer.fromColors(
      baseColor: effectiveBaseColor,
      highlightColor: highlightColor!,
      direction: ShimmerDirection.ltr,
      period: const Duration(milliseconds: 1000),
      child: buildShimmer(context),
    );
  }
}