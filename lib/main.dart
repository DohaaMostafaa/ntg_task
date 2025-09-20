import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/services/language_service.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit/cubit.dart';
import 'core/theme/theme_cubit/states.dart';
import 'features/cart/domain/usecases/cart_usecases.dart';
import 'features/cart/presentation/cart_cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await EasyLocalization.ensureInitialized();
  final themeCubit = ThemeCubit();
  await themeCubit.loadTheme();
  final savedLocale = await LanguageService.getSavedLanguage();


  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => themeCubit),
        BlocProvider(
          create: (_) => CartCubit(
            sl<GetAllCartItems>(),
            sl<AddCartItem>(),
            sl<UpdateCartItem>(),
            sl<DeleteCartItem>(),
            sl<ClearCart>(),
          )..loadCartFromDB(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) => EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('ar'),
          startLocale:savedLocale ,
          child: const MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final cubit = ThemeCubit.get(context);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: appRouter,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: cubit.currentMode,
          themeAnimationCurve: Curves.fastOutSlowIn,
          themeAnimationDuration: const Duration(milliseconds: 1000),
        );
      },
    );
  }
}
