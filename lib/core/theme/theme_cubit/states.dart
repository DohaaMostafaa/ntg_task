import 'package:flutter/material.dart';

abstract class ThemeState {}

class ThemeInitial extends ThemeState {}
class ThemeChanged extends ThemeState {
  final ThemeMode mode;
  ThemeChanged(this.mode);
}
