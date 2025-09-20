import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class AppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const AppBarAction({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      margin: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrey,style: BorderStyle.solid),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon,),
      ),
    );
  }
}
