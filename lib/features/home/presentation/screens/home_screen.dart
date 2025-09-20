import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ntg_task/features/home/domain/usecases/product_details_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/helpers/spacing_helper.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../../../../core/services/language_service.dart';
import '../../../../core/theme/theme_cubit/cubit.dart';
import '../../../../core/theme/theme_cubit/states.dart';
import '../../../../core/widgets/app_bar_actions.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../domain/usecases/categories_usecases.dart';
import '../../domain/usecases/products_usecases.dart';
import '../cubit/bottom_nav_cubit/cubit.dart';
import '../cubit/bottom_nav_cubit/states.dart';
import '../cubit/home_cubit/cubit.dart';
import '../widgets/app_name.dart';
import '../widgets/bottom_bar_widget.dart';
import '../widgets/categories_widget.dart';
import '../widgets/home_banner.dart';
import '../widgets/location_bar.dart';
import '../widgets/flash_sale_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create:
              (_) => HomeCubit(
                sl<GetAllCategories>(),
                sl<GetProductDetails>(),
                sl<GetAllProducts>(),
              )..init(),
        ),
        BlocProvider<BottomNavCubit>(create: (_) => BottomNavCubit()),
      ],
      child: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.all(12.w),
        child: CustomScrollView(
          slivers: [
            // Banner Section
            SliverToBoxAdapter(child: const BannerSlider()),
            SliverToBoxAdapter(child: verticalSpace(15.h)),

            // Categories Section
            SliverToBoxAdapter(
              child: TitleWidget(title: LocaleKeys.categories.tr()),
            ),
            SliverToBoxAdapter(child: verticalSpace(15.h)),
            SliverToBoxAdapter(child: const CategoriesGrid()),
            SliverToBoxAdapter(child: verticalSpace(15.h)),

            // Flash Sale Section
            SliverToBoxAdapter(
              child: TitleWidget(title: LocaleKeys.flash_sale.tr()),
            ),
            SliverToBoxAdapter(child: verticalSpace(15.h)),
            SliverToBoxAdapter(child: const FlashSaleSection()),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          return CustomBottomBar(
            selectedIndex: state.currentIndex,
            onTap: (index) => context.read<BottomNavCubit>().updateIndex(index),
          );
        },
      ),
    );
  }
}

AppBar _buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    surfaceTintColor: Theme.of(context).appBarTheme.surfaceTintColor,
    title: ShimmerAppTitle(fontSize: 22.sp),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(60.h),
      child: const LocationBar(),
    ),
    actionsIconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
    actions: [
      AppBarAction(icon: Icons.language_outlined, onPressed: () async {
        await LanguageService.toggleLanguage(context);
      }),

      BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final cubit = ThemeCubit.get(context);
          return AppBarAction(
            icon:
                cubit.currentMode == ThemeMode.dark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
            onPressed: cubit.toggleTheme,
          );
        },
      ),
    ],
  );
}
