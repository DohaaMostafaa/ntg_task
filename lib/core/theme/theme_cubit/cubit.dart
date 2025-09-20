import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ntg_task/core/theme/theme_cubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  static ThemeCubit get(context) => BlocProvider.of(context);

  ThemeMode currentMode = ThemeMode.light;

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    currentMode = isDark ? ThemeMode.dark : ThemeMode.light;
    emit(ThemeChanged(currentMode));
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (currentMode == ThemeMode.light) {
      currentMode = ThemeMode.dark;
      await prefs.setBool('isDark', true);
    } else {
      currentMode = ThemeMode.light;
      await prefs.setBool('isDark', false);
    }

    emit(ThemeChanged(currentMode));
  }
}
