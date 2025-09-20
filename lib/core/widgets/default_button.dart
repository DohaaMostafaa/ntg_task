import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const DefaultButton({required this.title,required this.onPressed,super.key});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: EdgeInsets.symmetric(horizontal: 17.w),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
