import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: const ColorScheme.light().copyWith(
      background: AppColors.lightGrey,
      primaryContainer: AppColors.black,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      actionsPadding: EdgeInsets.all(5.w),
      actionsIconTheme: const IconThemeData(color: AppColors.black),
      iconTheme: const IconThemeData(color: Colors.black),
    ),

    textTheme: TextTheme(
      displaySmall: TextStyle(color: AppColors.blueGrey, fontSize: 14.sp),
      bodyLarge: TextStyle(
        color: AppColors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
        color: AppColors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: AppColors.primary,
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: TextStyle(color: AppColors.grey, fontSize: 12.sp),
      labelSmall: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.black,size: 30),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.darkBackground,
      backgroundColor: AppColors.white,
      type: BottomNavigationBarType.fixed,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme.dark().copyWith(
      background: AppColors.grey,
      primaryContainer: AppColors.grey,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      actionsPadding: EdgeInsets.all(5.w),
      actionsIconTheme: const IconThemeData(color: AppColors.white),
      iconTheme: const IconThemeData(color: AppColors.white),
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(color: AppColors.lightGrey, fontSize: 14.sp),
      bodyLarge: TextStyle(color: AppColors.white, fontSize: 16.sp),
      bodyMedium: TextStyle(color: AppColors.white, fontSize: 14.sp),
      titleLarge: TextStyle(
        color: AppColors.primary,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(color: AppColors.grey, fontSize: 12.sp),
      labelSmall: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.white,
      backgroundColor: AppColors.darkBackground,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
