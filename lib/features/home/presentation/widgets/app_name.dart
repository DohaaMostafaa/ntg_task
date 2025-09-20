import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/base_shimmer.dart';

class ShimmerAppTitle extends BaseShimmer{
  final double fontSize;
  const ShimmerAppTitle({required this.fontSize ,super.key}) : super(
    baseColor:AppColors.primary ,
    highlightColor: AppColors.lightGrey,
  );

  @override
  Widget buildShimmer(BuildContext context) {
    return Text(
      'NTG App',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}





