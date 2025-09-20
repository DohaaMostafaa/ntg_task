import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntg_task/core/localization/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/helpers/spacing_helper.dart';
import '../../../cart/presentation/cart_cubit/cubit.dart';
import '../../../cart/presentation/cart_cubit/states.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomNavTheme = theme.bottomNavigationBarTheme;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cartCubit = CartCubit.get(context);
        final totalQuantity = cartCubit.totalQuantity;

        final navItems = [
          _NavItemData(
            icon: Iconsax.home,
            label: LocaleKeys.home.tr(),
            route: 'home',
          ),
          _NavItemData(
            icon: Iconsax.discover,
            label: LocaleKeys.search.tr(),
          ),
          _NavItemData(
            icon: Iconsax.shopping_bag,
            label: LocaleKeys.bag.tr(),
            route: 'cart',
            badgeCount: totalQuantity,
          ),
          _NavItemData(
            icon: Iconsax.heart,
            label: LocaleKeys.favorites.tr(),
          ),
          _NavItemData(
            icon: Iconsax.profile_circle,
            label: LocaleKeys.profile.tr(),
          ),
        ];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: bottomNavTheme.backgroundColor ??
                theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            boxShadow: [
              BoxShadow(
                color: theme.brightness == Brightness.dark
                    ? Colors.black.withOpacity(0.6)
                    : AppColors.lightGrey,
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              navItems.length,
                  (i) => _buildNavItem(
                context: context,
                data: navItems[i],
                index: i,
                isSelected: selectedIndex == i,
                onTap: (index) async {
                  onTap(index);
                  if (navItems[index].route != null) {
                    GoRouter.of(context).goNamed(navItems[index].route!);
                    if (navItems[index].route == 'cart') {
                      await cartCubit.loadCartFromDB();
                    }
                  }
                },
                selectedColor: bottomNavTheme.selectedItemColor,
                unselectedColor: bottomNavTheme.unselectedItemColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required _NavItemData data,
    required int index,
    required bool isSelected,
    required Function(int) onTap,
    required Color? selectedColor,
    required Color? unselectedColor,
  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final effectiveSelectedColor = selectedColor ?? AppColors.primary;
    final effectiveUnselectedColor = unselectedColor ??
        (theme.brightness == Brightness.dark ? Colors.grey[400] : Colors.black);

    return GestureDetector(
      onTap: () => onTap(index),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: isSelected
                ? EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h)
                : EdgeInsets.all(10.w),
            decoration: isSelected
                ? BoxDecoration(
              color: effectiveSelectedColor,
              borderRadius: BorderRadius.circular(30),
            )
                : null,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  data.icon,
                  color: isSelected ? Colors.white : effectiveUnselectedColor,
                  size: 24.sp,
                ),
                if (isSelected) ...[
                  horizontalSpace(6.w),
                  Text(
                    data.label,
                    style: textTheme.labelSmall,
                  ),
                ],
              ],
            ),
          ),
          if (data.badgeCount > 0)
            Positioned(
              right: -6.w,
              top: -6.h,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: const BoxDecoration(
                  color: AppColors.redColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  data.badgeCount > 99 ? '99+' : '${data.badgeCount}',style: (TextStyle(color: Colors.white)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final String label;
  final String? route;
  final int badgeCount;

  const _NavItemData({
    required this.icon,
    required this.label,
    this.route,
    this.badgeCount = 0,
  });
}
